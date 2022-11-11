import Foundation
import Domain
import UIKit

public class FavoritesAssembly {
    
    private let navigationController: UINavigationController
    private let fetchFavoritesFromStoredUseCase: FetchFavoritesFromStoredUseCase
    private let updateFavoriteImageUseCase: UpdateFavoriteImageUseCase
    private let getBreedImageDBUseCase: GetBreedImageDBUseCase
    
    public init(navigationController: UINavigationController,
                fetchFavoritesFromStoredUseCase: FetchFavoritesFromStoredUseCase,
                updateFavoriteImageUseCase: UpdateFavoriteImageUseCase,
                getBreedImageDBUseCase: GetBreedImageDBUseCase) {
        
        self.navigationController = navigationController
        self.fetchFavoritesFromStoredUseCase = fetchFavoritesFromStoredUseCase
        self.updateFavoriteImageUseCase = updateFavoriteImageUseCase
        self.getBreedImageDBUseCase = getBreedImageDBUseCase
    }
    
    public func build() -> UIViewController {
        FavoritesViewController(viewModel: makeViewModel())
    }
}

extension FavoritesAssembly {
    private func makeViewModel() -> FavoritesViewModel {
        FavoritesViewModel(fetchFavoritesFromStoredUseCase: fetchFavoritesFromStoredUseCase,
                           updateFavoriteImageUseCase: updateFavoriteImageUseCase,
                           getBreedImageDBUseCase: getBreedImageDBUseCase)
    }
}
