import Foundation
import Combine
@testable import Domain

public struct MockServiceRepository: ServiceRepository {
    
    public init() {}
    
    public func fetchBreeds() -> AnyPublisher<[Breed], Error> {
        
        let mockedResponse = [Breed(name: "name1"),
                              Breed(name: "name2"),
                              Breed(name: "name3")
        ]
                
        return Just(mockedResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    public func fetchBreedImagesBy(breed: String) -> AnyPublisher<[BreedImage], Error> {
        let mockedResponse = [BreedImage(imageUrl: "imageUrl1"),
                              BreedImage(imageUrl: "imageUrl2"),
                              BreedImage(imageUrl: "imageUrl3")
        ]
                
        return Just(mockedResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
