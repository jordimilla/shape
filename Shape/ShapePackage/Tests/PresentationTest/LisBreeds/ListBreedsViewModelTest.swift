@testable import Domain
@testable import Presentation
@testable import Data
import Foundation
import Combine
import XCTest

class ListBreedsViewModelTest: XCTestCase {
    
    var viewModel: ListBreedsViewModel?
    var fetchBreedsUseCase: FetchBreedsUseCase!
    var createBreedDBEntitiesUseCase: CreateBreedDBEntitiesUseCase!
    var fetchBreedsFromStoredUseCase: FetchBreedsFromStoredUseCase!
    
    var breedPicturesFeature: SingleParamFeatureProvider<Breed> = { _,_ in
        return UIViewController()
    }
    var favoritesPicturesFeature: FeatureProvider = { _ in
        return UIViewController()
    }

    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    //MARK: - Setup
    
    override func setUpWithError() throws {

        fetchBreedsUseCase = FetchBreedsUseCase(repository: MockServiceRepository())
        createBreedDBEntitiesUseCase = CreateBreedDBEntitiesUseCase(coreDataRepository: MockCoreDataRepository())
        fetchBreedsFromStoredUseCase = FetchBreedsFromStoredUseCase(coreDataRepository: MockCoreDataRepository())

        viewModel = ListBreedsViewModel(fetchBreedsUseCase: fetchBreedsUseCase,
                                        createBreedDBEntitiesUseCase: createBreedDBEntitiesUseCase,
                                        fetchBreedsFromStoredUseCase: fetchBreedsFromStoredUseCase,
                                        breedPicturesFeature: breedPicturesFeature,
                                        favoritesPicturesFeature: favoritesPicturesFeature)
        
        guard viewModel != nil else {
            XCTFail("ViewModel is nil")
            return
        }
    }
    
    //MARK: - Tests
    func test_fetchBreedsUseCase() {
        let expectation = XCTestExpectation(description: self.description)
        
        viewModel?.$breeds
            .sink(receiveValue: { breeds in
                guard let breeds = breeds.last else {
                    return
                }
                XCTAssertNotNil(breeds)
                XCTAssertEqual(breeds.name, "name3")
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        viewModel?.fetchBreeds()
        
        wait(for: [expectation], timeout: 1)
    }
}
