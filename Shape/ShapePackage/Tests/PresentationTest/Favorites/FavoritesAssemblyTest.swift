@testable import Domain
@testable import Presentation
import XCTest

final class FavoritesAssemblyTest: XCTestCase {
    
    var sut: FavoritesAssembly!

    var fetchFavoritesFromStoredUseCase: FetchFavoritesFromStoredUseCase!
    var fetchBreedImagesFromStoredUseCase: FetchBreedImagesFromStoredUseCase!
    var updateFavoriteImageUseCase: UpdateFavoriteImageUseCase!
    var getBreedImageDBUseCase: GetBreedImageDBUseCase!
    
    override func setUp() {
        super.setUp()
       
        fetchFavoritesFromStoredUseCase = FetchFavoritesFromStoredUseCase(coreDataRepository: MockCoreDataRepository())
        updateFavoriteImageUseCase = UpdateFavoriteImageUseCase(coreDataRepository: MockCoreDataRepository())
        getBreedImageDBUseCase = GetBreedImageDBUseCase(coreDataRepository: MockCoreDataRepository())
        
        sut = FavoritesAssembly(navigationController: UINavigationController(),
                                fetchFavoritesFromStoredUseCase: fetchFavoritesFromStoredUseCase,
                                updateFavoriteImageUseCase: updateFavoriteImageUseCase,
                                getBreedImageDBUseCase: getBreedImageDBUseCase)

    }
    
    func test_get_favorites_viewcontroller_when_build() {
        let viewController = sut.build()
        
        XCTAssertTrue(viewController is FavoritesViewController)
    }
}
