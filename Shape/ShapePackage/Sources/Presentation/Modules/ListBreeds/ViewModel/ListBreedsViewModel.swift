import Domain
import Foundation
import Combine
import UIKit.UINavigationController

final class ListBreedsViewModel {
    
    private let fetchBreedsUseCase: FetchBreedsUseCase
    private let createBreedDBEntitiesUseCase: CreateBreedDBEntitiesUseCase
    private let fetchBreedsFromStoredUseCase: FetchBreedsFromStoredUseCase
    private let breedPicturesFeature: SingleParamFeatureProvider<Breed>
    private let favoritesPicturesFeature: FeatureProvider
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var breeds: [Breed] = []
    
    init(fetchBreedsUseCase: FetchBreedsUseCase,
         createBreedDBEntitiesUseCase: CreateBreedDBEntitiesUseCase,
         fetchBreedsFromStoredUseCase: FetchBreedsFromStoredUseCase,
         breedPicturesFeature: @escaping SingleParamFeatureProvider<Breed>,
         favoritesPicturesFeature: @escaping FeatureProvider) {
        
        self.fetchBreedsUseCase = fetchBreedsUseCase
        self.createBreedDBEntitiesUseCase = createBreedDBEntitiesUseCase
        self.fetchBreedsFromStoredUseCase = fetchBreedsFromStoredUseCase
        self.breedPicturesFeature = breedPicturesFeature
        self.favoritesPicturesFeature = favoritesPicturesFeature
    }
    
    func goToPictures(navigationController: UINavigationController, post: Breed) {
        let viewController = breedPicturesFeature(navigationController, post)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToFavorites(navigationController: UINavigationController) {
        let viewController = favoritesPicturesFeature(navigationController)
        navigationController.pushViewController(viewController, animated: true)
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
                self?.createEntity(breeds: items)
            })
            .store(in: &cancellables)
    }
}

// MARK: - CoreData
extension ListBreedsViewModel {
    func createEntity(breeds: [Breed]) {
        createBreedDBEntitiesUseCase.execute(value: breeds)
    }
    
    func fetchBreedsFromStored() {
        fetchBreedsFromStoredUseCase.execute(value: ())
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] items in
                if items.count == 0 {
                    self?.fetchBreeds()
                } else {
                    let breeds = BreedDB.mapBreeds(input: items)
                    self?.breeds = breeds
                }
            })
            .store(in: &cancellables)
    }
}
