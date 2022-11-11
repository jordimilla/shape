import XCTest
import Combine
import Domain

final class ApiUsesCasesTest: XCTestCase {
    
    var fetchBreedsUseCase: FetchBreedsUseCase?
    var fetchBreedImagesUseCase: FetchBreedImagesUseCase?
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    //MARK: - Setup
    
    override func setUpWithError() throws {
        
        self.fetchBreedsUseCase = FetchBreedsUseCase(repository: MockServiceRepository())
        self.fetchBreedImagesUseCase = FetchBreedImagesUseCase(repository: MockServiceRepository())
        
        guard self.fetchBreedsUseCase != nil,
              self.fetchBreedImagesUseCase != nil else {
            XCTFail("Usecase is nil")
            return
        }
    }
    
    //MARK: - Tests
    func test_fetchBreedsUseCase() {
        fetchBreedsUseCase?.execute(value:())
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { item in
                XCTAssertGreaterThan(item.count, 0)
            }
            .store(in: &cancellables)
    }
    
    func test_fetchBreedImagesUseCase() {
        fetchBreedImagesUseCase?.execute(value: "")
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { item in
                XCTAssertGreaterThan(item.count, 0)
            }
            .store(in: &cancellables)
    }
    
}
