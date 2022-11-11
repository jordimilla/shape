import XCTest
import Combine
@testable import Domain

final class CoreDataUsesCasesTest: XCTestCase {
    
    var getBreedImageDBUseCase: GetBreedImageDBUseCase?
    var fetchBreedsFromStoredUseCase: FetchBreedsFromStoredUseCase?
    var fetchBreedImagesFromStoredUseCase: FetchBreedImagesFromStoredUseCase?
    var fetchFavoritesFromStoredUseCase: FetchFavoritesFromStoredUseCase?
    var updateFavoriteImageUseCase: UpdateFavoriteImageUseCase?

    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        self.getBreedImageDBUseCase = GetBreedImageDBUseCase(coreDataRepository: MockCoreDataRepository())
        self.fetchBreedsFromStoredUseCase = FetchBreedsFromStoredUseCase(coreDataRepository: MockCoreDataRepository())
        self.fetchBreedImagesFromStoredUseCase = FetchBreedImagesFromStoredUseCase(coreDataRepository: MockCoreDataRepository())
        self.fetchFavoritesFromStoredUseCase = FetchFavoritesFromStoredUseCase(coreDataRepository: MockCoreDataRepository())
        self.updateFavoriteImageUseCase = UpdateFavoriteImageUseCase(coreDataRepository: MockCoreDataRepository())
        
        guard self.getBreedImageDBUseCase != nil,
              self.fetchBreedsFromStoredUseCase != nil,
              self.fetchBreedImagesFromStoredUseCase != nil,
              self.fetchFavoritesFromStoredUseCase != nil,
              self.updateFavoriteImageUseCase != nil else {
                  XCTFail("Usecase is nil")
                  return
              }
    }
    
    //MARK: - Tests
    func test_getPostDBUseCase() {
        
        getBreedImageDBUseCase?.execute(value: "")
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { breedImage in
                XCTAssertTrue(true)
            }
            .store(in: &cancellables)
    }
    
    func test_fetchBreedsFromStoredUseCase() {
        fetchBreedsFromStoredUseCase?.execute(value: ())
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { breedImage in
                XCTAssertTrue(true)
            }
            .store(in: &cancellables)
    }
    
    func test_fetchBreedImagesFromStoredUseCase() {
        fetchBreedImagesFromStoredUseCase?.execute(value: "")
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { breedImage in
                XCTAssertTrue(true)
            }
            .store(in: &cancellables)
    }
    
    func test_fetchFavoritesFromStoredUseCase() {
        fetchFavoritesFromStoredUseCase?.execute(value: ())
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { breedImage in
                XCTAssertTrue(true)
            }
            .store(in: &cancellables)
    }
    
    func test_updateFavoriteImageUseCase() {
        let breedImageDB = BreedImageDB()
        updateFavoriteImageUseCase?.execute(value: breedImageDB)
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { breedImage in
                XCTAssertTrue(true)
            }
            .store(in: &cancellables)
    }
}
