import Foundation
import Domain
import UIKit

public class ListBreedsAssembly {
    
    private let fetchBreedsUseCase: FetchBreedsUseCase
    private let breedPicturesFeature: SingleParamFeatureProvider<Breed>
    private let favoritesPicturesFeature: FeatureProvider
    
    public init(fetchBreedsUseCase: FetchBreedsUseCase,
                breedPicturesFeature: @escaping SingleParamFeatureProvider<Breed>,
                favoritesPicturesFeature: @escaping FeatureProvider) {
        self.fetchBreedsUseCase = fetchBreedsUseCase
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
                            breedPicturesFeature: breedPicturesFeature,
                            favoritesPicturesFeature: favoritesPicturesFeature)
    }
}
