@testable import Domain
@testable import Presentation
@testable import Data
import Foundation
import Combine
import XCTest

class BreedPicturesViewModelTest: XCTestCase {
    
    var viewModel: BreedPicturesViewModel?
    var fetchBreedImagesUseCase: FetchBreedImagesUseCase!
    var breed: Breed!
    var createBreedImagesDBEntitiesUseCase: CreateBreedImagesDBEntitiesUseCase!
    var fetchBreedImagesFromStoredUseCase: FetchBreedImagesFromStoredUseCase!
    var updateFavoriteImageUseCase: UpdateFavoriteImageUseCase!
    var getBreedImageDBUseCase: GetBreedImageDBUseCase!

    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    //MARK: - Setup
    
    override func setUpWithError() throws {

        breed = Breed(name: "")
        fetchBreedImagesUseCase = FetchBreedImagesUseCase(repository: MockServiceRepository())
        createBreedImagesDBEntitiesUseCase = CreateBreedImagesDBEntitiesUseCase(coreDataRepository: MockCoreDataRepository())
        fetchBreedImagesFromStoredUseCase = FetchBreedImagesFromStoredUseCase(coreDataRepository: MockCoreDataRepository())
        updateFavoriteImageUseCase = UpdateFavoriteImageUseCase(coreDataRepository: MockCoreDataRepository())
        getBreedImageDBUseCase = GetBreedImageDBUseCase(coreDataRepository: MockCoreDataRepository())

        viewModel = BreedPicturesViewModel(fetchBreedImagesUseCase: fetchBreedImagesUseCase,
                                           createBreedImagesDBEntitiesUseCase: createBreedImagesDBEntitiesUseCase,
                                           fetchBreedImagesFromStoredUseCase: fetchBreedImagesFromStoredUseCase,
                                           updateFavoriteImageUseCase: updateFavoriteImageUseCase,
                                           getBreedImageDBUseCase: getBreedImageDBUseCase,
                                           breed: breed)
        
        guard viewModel != nil else {
            XCTFail("ViewModel is nil")
            return
        }
    }
    
    //MARK: - Tests
    func test_fetchBreedImagesUseCase() {
        let expectation = XCTestExpectation(description: self.description)
        
        viewModel?.$breedImages
            .sink(receiveValue: { breeds in
                guard let breeds = breeds.last else {
                    return
                }
                XCTAssertNotNil(breeds)
                XCTAssertEqual(breeds.imageUrl, "imageUrl3")
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        viewModel?.fetchBreedImages()
        
        wait(for: [expectation], timeout: 1)
    }
}
