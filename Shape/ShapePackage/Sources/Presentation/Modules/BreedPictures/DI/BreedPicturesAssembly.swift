import Foundation
import Domain
import UIKit

public class BreedPicturesAssembly {
    
    private let navigationController: UINavigationController
    private let breed: Breed
    private let fetchBreedImagesUseCase: FetchBreedImagesUseCase
    private let createBreedImagesDBEntitiesUseCase: CreateBreedImagesDBEntitiesUseCase
    private let fetchBreedImagesFromStoredUseCase: FetchBreedImagesFromStoredUseCase
    private let updateFavoriteImageUseCase: UpdateFavoriteImageUseCase
    private let getBreedImageDBUseCase: GetBreedImageDBUseCase

    public init(navigationController: UINavigationController,
                breed: Breed,
                fetchBreedImagesUseCase: FetchBreedImagesUseCase,
                createBreedImagesDBEntitiesUseCase: CreateBreedImagesDBEntitiesUseCase,
                fetchBreedImagesFromStoredUseCase: FetchBreedImagesFromStoredUseCase,
                updateFavoriteImageUseCase: UpdateFavoriteImageUseCase,
                getBreedImageDBUseCase: GetBreedImageDBUseCase) {
        
        self.navigationController = navigationController
        self.breed = breed
        self.fetchBreedImagesUseCase = fetchBreedImagesUseCase
        self.createBreedImagesDBEntitiesUseCase = createBreedImagesDBEntitiesUseCase
        self.fetchBreedImagesFromStoredUseCase = fetchBreedImagesFromStoredUseCase
        self.updateFavoriteImageUseCase = updateFavoriteImageUseCase
        self.getBreedImageDBUseCase = getBreedImageDBUseCase
    }
    
    public func build() -> UIViewController {
        BreedPicturesViewController(viewModel: makeViewModel())
    }
}

extension BreedPicturesAssembly {
    private func makeViewModel() -> BreedPicturesViewModel {
        BreedPicturesViewModel(fetchBreedImagesUseCase: fetchBreedImagesUseCase,
                               createBreedImagesDBEntitiesUseCase: createBreedImagesDBEntitiesUseCase,
                               fetchBreedImagesFromStoredUseCase: fetchBreedImagesFromStoredUseCase,
                               updateFavoriteImageUseCase: updateFavoriteImageUseCase,
                               getBreedImageDBUseCase: getBreedImageDBUseCase,
                               breed: breed)
    }
}
