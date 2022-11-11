import Domain
import Foundation
import Combine

final class FavoritesViewModel {
    
    private let fetchFavoritesFromStoredUseCase: FetchFavoritesFromStoredUseCase
    private let updateFavoriteImageUseCase: UpdateFavoriteImageUseCase
    private let getBreedImageDBUseCase: GetBreedImageDBUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var breedImages: [BreedImage] = []
    
    init(fetchFavoritesFromStoredUseCase: FetchFavoritesFromStoredUseCase,
         updateFavoriteImageUseCase: UpdateFavoriteImageUseCase,
         getBreedImageDBUseCase: GetBreedImageDBUseCase) {
        
        self.fetchFavoritesFromStoredUseCase = fetchFavoritesFromStoredUseCase
        self.updateFavoriteImageUseCase = updateFavoriteImageUseCase
        self.getBreedImageDBUseCase = getBreedImageDBUseCase
    }
}

// MARK: - CoreData
extension FavoritesViewModel {
    func fetchBreedImagesFromStored() {
        fetchFavoritesFromStoredUseCase.execute(value: ())
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] items in
                let breedImages = BreedImageDB.mapBreedImage(input: items)
                self?.breedImages = breedImages
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
