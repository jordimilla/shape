import Domain
import Foundation
import Combine

final class BreedPicturesViewModel {
    
    private let fetchBreedImagesUseCase: FetchBreedImagesUseCase
    private let createBreedImagesDBEntitiesUseCase: CreateBreedImagesDBEntitiesUseCase
    private let fetchBreedImagesFromStoredUseCase: FetchBreedImagesFromStoredUseCase
    private let updateFavoriteImageUseCase: UpdateFavoriteImageUseCase
    private let getBreedImageDBUseCase: GetBreedImageDBUseCase
    let breed: Breed
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var breedImages: [BreedImage] = []
    
    init(fetchBreedImagesUseCase: FetchBreedImagesUseCase,
         createBreedImagesDBEntitiesUseCase: CreateBreedImagesDBEntitiesUseCase,
         fetchBreedImagesFromStoredUseCase: FetchBreedImagesFromStoredUseCase,
         updateFavoriteImageUseCase: UpdateFavoriteImageUseCase,
         getBreedImageDBUseCase: GetBreedImageDBUseCase,
         breed: Breed) {
        
        self.fetchBreedImagesUseCase = fetchBreedImagesUseCase
        self.createBreedImagesDBEntitiesUseCase = createBreedImagesDBEntitiesUseCase
        self.fetchBreedImagesFromStoredUseCase = fetchBreedImagesFromStoredUseCase
        self.updateFavoriteImageUseCase = updateFavoriteImageUseCase
        self.getBreedImageDBUseCase = getBreedImageDBUseCase
        self.breed = breed
    }
}

// MARK: - API
extension BreedPicturesViewModel {
    func fetchBreedImages() {
        fetchBreedImagesUseCase.execute(value: breed.name)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }, receiveValue: { [weak self] items in
                guard let breedImgs = self?.updateBreed(input: items, breed: self?.breed.name ?? "") else { return }
                self?.breedImages = breedImgs
                self?.createEntity(breedImages: breedImgs)
            })
            .store(in: &cancellables)
    }
    
    func updateBreed(input: [BreedImage], breed: String) -> [BreedImage] {
        return input.map { countK -> BreedImage in
            BreedImage(imageUrl: countK.imageUrl,
                       hasFavorite: countK.hasFavorite,
                       breed: breed)
        }
    }
}

// MARK: - CoreData
extension BreedPicturesViewModel {
    func createEntity(breedImages: [BreedImage]) {
        createBreedImagesDBEntitiesUseCase.execute(value: breedImages)
    }
    
    func fetchBreedImagesFromStored() {
        fetchBreedImagesFromStoredUseCase.execute(value: breed.name)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] items in
                if items.count == 0 {
                    self?.fetchBreedImages()
                } else {
                    let breedImages = BreedImageDB.mapBreedImage(input: items)
                    self?.breedImages = breedImages.sorted { $0.imageUrl < $1.imageUrl }
                }
            })
            .store(in: &cancellables)
    }
    
    func setFavoriteImage(image: BreedImage) {
        getBreedImageDBUseCase.execute(value: image.imageUrl)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] item in
                self?.updateImage(image: item)
            })
            .store(in: &cancellables)
        
    }
    
    func updateImage(image: BreedImageDB) {
        updateFavoriteImageUseCase.execute(value: image)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] success in
                print(success)
                self?.fetchBreedImagesFromStored()
            })
            .store(in: &cancellables)
    }
}
