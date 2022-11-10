import Foundation
import Domain
import UIKit

public class BreedPicturesAssembly {
    
    private let navigationController: UINavigationController
    private let breed: Breed
    private let fetchBreedImagesUseCase: FetchBreedImagesUseCase

    public init(navigationController: UINavigationController,
                breed: Breed,
                fetchBreedImagesUseCase: FetchBreedImagesUseCase) {
        self.navigationController = navigationController
        self.breed = breed
        self.fetchBreedImagesUseCase = fetchBreedImagesUseCase
    }
    
    public func build() -> UIViewController {
        BreedPicturesViewController(viewModel: makeViewModel())
    }
}

extension BreedPicturesAssembly {
    private func makeViewModel() -> BreedPicturesViewModel {
        BreedPicturesViewModel(fetchBreedImagesUseCase: fetchBreedImagesUseCase,
                               breed: breed)
    }
}
