import Foundation
import Domain
import UIKit

public class ListBreedsAssembly {
    
    private let fetchBreedsUseCase: FetchBreedsUseCase
    private let createBreedDBEntitiesUseCase: CreateBreedDBEntitiesUseCase
    private let fetchBreedsFromStoredUseCase: FetchBreedsFromStoredUseCase
    private let breedPicturesFeature: SingleParamFeatureProvider<Breed>
    private let favoritesPicturesFeature: FeatureProvider
    
    public init(fetchBreedsUseCase: FetchBreedsUseCase,
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
    
    public func build() -> UIViewController {
        ListBreedsViewController(viewModel: makeViewModel())
    }
}

extension ListBreedsAssembly {
    private func makeViewModel() -> ListBreedsViewModel {
        ListBreedsViewModel(fetchBreedsUseCase: fetchBreedsUseCase,
                            createBreedDBEntitiesUseCase: createBreedDBEntitiesUseCase,
                            fetchBreedsFromStoredUseCase: fetchBreedsFromStoredUseCase,
                            breedPicturesFeature: breedPicturesFeature,
                            favoritesPicturesFeature: favoritesPicturesFeature)
    }
}
