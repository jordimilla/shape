import Domain
import Data
import Presentation

public class AppAssembly {
    
    public static let listBreedsFeature: ViewControllerProvider = {
        
        let fetchBreedsUseCase = FetchBreedsUseCase(repository: ServiceRepositoryAssembly.makeServiceRepository())
        let createBreedDBEntitiesUseCase = CreateBreedDBEntitiesUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let fetchBreedsFromStoredUseCase = FetchBreedsFromStoredUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        
        return ListBreedsAssembly(fetchBreedsUseCase: fetchBreedsUseCase,
                                  createBreedDBEntitiesUseCase: createBreedDBEntitiesUseCase,
                                  fetchBreedsFromStoredUseCase: fetchBreedsFromStoredUseCase,
                                  breedPicturesFeature: breedPicturesFeature,
                                  favoritesPicturesFeature: favoritesFeature).build()
    }
    
    public static let breedPicturesFeature: SingleParamFeatureProvider<Breed>  = { navigationController, breed in
        
        let fetchBreedImagesUseCase = FetchBreedImagesUseCase(repository: ServiceRepositoryAssembly.makeServiceRepository())
        
        return BreedPicturesAssembly(navigationController: navigationController,
                                     breed: breed,
                                     fetchBreedImagesUseCase: fetchBreedImagesUseCase).build()
    }
    
    public static let favoritesFeature: FeatureProvider  = { navigationController in
        
        return FavoritesAssembly().build()
    }
}
