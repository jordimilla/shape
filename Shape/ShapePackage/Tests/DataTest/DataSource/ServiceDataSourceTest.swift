import XCTest
import Combine
import Domain

class ServiceDataSourceTest: XCTestCase {

    var dataSource: MockServiceRepository?
    
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        dataSource = MockServiceRepository()
        
        guard dataSource != nil else {
            XCTFail("DataSource is nil")
            return
        }
    }
    
    func test_fetchBreeds() {
        
        dataSource?.fetchBreeds()
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { response in
                XCTAssertGreaterThan(response.count, 0)
                XCTAssertEqual(response[0].name, "name1")
            }
            .store(in: &cancellables)
    }
    
    func test_fetchBreedImagesBy() {
        dataSource?.fetchBreedImagesBy(breed: "")
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { response in
                XCTAssertGreaterThan(response.count, 0)
                XCTAssertEqual(response[0].imageUrl, "imageUrl1")
            }
            .store(in: &cancellables)
    }
}
