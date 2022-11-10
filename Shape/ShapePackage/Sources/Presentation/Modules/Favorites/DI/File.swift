import Foundation
import Domain
import UIKit

public class FavoritesAssembly {
    
    public init() {
    }
    
    public func build() -> UIViewController {
        FavoritesViewController(viewModel: makeViewModel())
    }
}

extension FavoritesAssembly {
    private func makeViewModel() -> FavoritesViewModel {
        FavoritesViewModel()
    }
}
