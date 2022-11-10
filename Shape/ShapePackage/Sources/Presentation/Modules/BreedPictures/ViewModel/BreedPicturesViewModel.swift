import Domain
import Foundation
import Combine

final class BreedPicturesViewModel {
    
    private let fetchBreedImagesUseCase: FetchBreedImagesUseCase
    let breed: Breed
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var breedImages: [BreedImage] = []
    
    init(fetchBreedImagesUseCase: FetchBreedImagesUseCase,
         breed: Breed) {
        self.fetchBreedImagesUseCase = fetchBreedImagesUseCase
        self.breed = breed
    }
}

// MARK: - API
extension BreedPicturesViewModel {
    func fetchBreedImagesBy() {
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
                self?.breedImages = items
            })
            .store(in: &cancellables)
    }
}
