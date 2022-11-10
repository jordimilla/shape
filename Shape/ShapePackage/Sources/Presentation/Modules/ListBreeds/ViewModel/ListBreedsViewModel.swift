import Domain
import Foundation
import Combine
import UIKit.UINavigationController

final class ListBreedsViewModel {
    
    private let fetchBreedsUseCase: FetchBreedsUseCase
    private let breedPicturesFeature: SingleParamFeatureProvider<Breed>
    private let favoritesPicturesFeature: SingleParamFeatureProvider<Breed>
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var breeds: [Breed] = []
    
    init(fetchBreedsUseCase: FetchBreedsUseCase,
         breedPicturesFeature: @escaping SingleParamFeatureProvider<Breed>,
         favoritesPicturesFeature: @escaping SingleParamFeatureProvider<Breed>) {
        
        self.fetchBreedsUseCase = fetchBreedsUseCase
        self.breedPicturesFeature = breedPicturesFeature
        self.favoritesPicturesFeature = favoritesPicturesFeature
    }
    
    func goToPictures(navigationController: UINavigationController, post: Breed) {
        let viewController = breedPicturesFeature(navigationController, post)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToFavorites() {
        
    }
}

// MARK: - API
extension ListBreedsViewModel {
    func fetchBreeds() {
        fetchBreedsUseCase.execute(value: ())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }, receiveValue: { [weak self] items in
                self?.breeds = items
            })
            .store(in: &cancellables)
    }
}
