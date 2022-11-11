@testable import Domain
@testable import Presentation
import XCTest

final class BreedPicturesAssemblyTest: XCTestCase {
    
    var sut: BreedPicturesAssembly!
    var fetchBreedImagesUseCase: FetchBreedImagesUseCase!
    var breed: Breed!
    var createBreedImagesDBEntitiesUseCase: CreateBreedImagesDBEntitiesUseCase!
    var fetchBreedImagesFromStoredUseCase: FetchBreedImagesFromStoredUseCase!
    var updateFavoriteImageUseCase: UpdateFavoriteImageUseCase!
    var getBreedImageDBUseCase: GetBreedImageDBUseCase!
    
    override func setUp() {
        super.setUp()
       
        breed = Breed(name: "")
        fetchBreedImagesUseCase = FetchBreedImagesUseCase(repository: MockServiceRepository())
        createBreedImagesDBEntitiesUseCase = CreateBreedImagesDBEntitiesUseCase(coreDataRepository: MockCoreDataRepository())
        fetchBreedImagesFromStoredUseCase = FetchBreedImagesFromStoredUseCase(coreDataRepository: MockCoreDataRepository())
        updateFavoriteImageUseCase = UpdateFavoriteImageUseCase(coreDataRepository: MockCoreDataRepository())
        getBreedImageDBUseCase = GetBreedImageDBUseCase(coreDataRepository: MockCoreDataRepository())
        
        sut = BreedPicturesAssembly(navigationController: UINavigationController(),
                                    breed: breed,
                                    fetchBreedImagesUseCase: fetchBreedImagesUseCase,
                                    createBreedImagesDBEntitiesUseCase: createBreedImagesDBEntitiesUseCase,
                                    fetchBreedImagesFromStoredUseCase: fetchBreedImagesFromStoredUseCase,
                                    updateFavoriteImageUseCase: updateFavoriteImageUseCase,
                                    getBreedImageDBUseCase: getBreedImageDBUseCase)

    }
    
    func test_get_pictures_viewcontroller_when_build() {
        let viewController = sut.build()
        
        XCTAssertTrue(viewController is BreedPicturesViewController)
    }
}
