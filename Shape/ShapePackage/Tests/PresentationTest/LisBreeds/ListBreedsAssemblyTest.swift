@testable import Domain
@testable import Presentation
import XCTest

final class ListBreedsAssemblyTest: XCTestCase {
    
    var sut: ListBreedsAssembly!
    var fetchBreedsUseCase: FetchBreedsUseCase!
    var createBreedDBEntitiesUseCase: CreateBreedDBEntitiesUseCase!
    var fetchBreedsFromStoredUseCase: FetchBreedsFromStoredUseCase!
    
    var breedPicturesFeature: SingleParamFeatureProvider<Breed> = { _,_ in
        return UIViewController()
    }
    var favoritesPicturesFeature: FeatureProvider = { _ in
        return UIViewController()
    }
    
    override func setUp() {
        super.setUp()
       
        fetchBreedsUseCase = FetchBreedsUseCase(repository: MockServiceRepository())
        createBreedDBEntitiesUseCase = CreateBreedDBEntitiesUseCase(coreDataRepository: MockCoreDataRepository())
        fetchBreedsFromStoredUseCase = FetchBreedsFromStoredUseCase(coreDataRepository: MockCoreDataRepository())
        
        sut = ListBreedsAssembly(fetchBreedsUseCase: fetchBreedsUseCase,
                                 createBreedDBEntitiesUseCase: createBreedDBEntitiesUseCase,
                                 fetchBreedsFromStoredUseCase: fetchBreedsFromStoredUseCase,
                                 breedPicturesFeature: breedPicturesFeature,
                                 favoritesPicturesFeature: favoritesPicturesFeature)

    }
    
    func test_get_listbreed_viewcontroller_when_build() {
        let viewController = sut.build()
        
        XCTAssertTrue(viewController is ListBreedsViewController)
    }
}
