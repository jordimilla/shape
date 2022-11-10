import Foundation
import Domain
import UIKit

public class ListBreedsAssembly {
    
    private let fetchBreedsUseCase: FetchBreedsUseCase

    public init(fetchBreedsUseCase: FetchBreedsUseCase) {
        self.fetchBreedsUseCase = fetchBreedsUseCase
    }
    
    public func build() -> UIViewController {
        ListBreedsViewController(viewModel: makeViewModel())
    }
}

extension ListBreedsAssembly {
    private func makeViewModel() -> ListBreedsViewModel {
        ListBreedsViewModel(fetchBreedsUseCase: fetchBreedsUseCase)
    }
}
