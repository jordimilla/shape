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
        let createBreedImagesDBEntitiesUseCase = CreateBreedImagesDBEntitiesUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let fetchBreedImagesFromStoredUseCase = FetchBreedImagesFromStoredUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let updateFavoriteImageUseCase = UpdateFavoriteImageUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let getBreedImageDBUseCase = GetBreedImageDBUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        
        return BreedPicturesAssembly(navigationController: navigationController,
                                     breed: breed,
                                     fetchBreedImagesUseCase: fetchBreedImagesUseCase,
                                     createBreedImagesDBEntitiesUseCase: createBreedImagesDBEntitiesUseCase,
                                     fetchBreedImagesFromStoredUseCase: fetchBreedImagesFromStoredUseCase,
                                     updateFavoriteImageUseCase: updateFavoriteImageUseCase,
                                     getBreedImageDBUseCase: getBreedImageDBUseCase).build()
    }
    
    public static let favoritesFeature: FeatureProvider  = { navigationController in
        
        let fetchFavoritesFromStoredUseCase = FetchFavoritesFromStoredUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let updateFavoriteImageUseCase = UpdateFavoriteImageUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        let getBreedImageDBUseCase = GetBreedImageDBUseCase(coreDataRepository: ServiceRepositoryAssembly.makeCoreDataRepository())
        
        return FavoritesAssembly(navigationController: navigationController,
                                 fetchFavoritesFromStoredUseCase: fetchFavoritesFromStoredUseCase,
                                 updateFavoriteImageUseCase: updateFavoriteImageUseCase,
                                 getBreedImageDBUseCase: getBreedImageDBUseCase).build()
    }
}
