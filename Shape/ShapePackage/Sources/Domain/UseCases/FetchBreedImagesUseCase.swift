import Foundation
import Combine

public struct FetchBreedImagesUseCase: ServiceUseCase {
    typealias RequestValue = String
    typealias ResponseValue = AnyPublisher<[BreedImage], Error>
    let repository: ServiceRepository
    
    public init(repository: ServiceRepository) {
        self.repository = repository
    }
    
    public func execute(value: String) -> AnyPublisher<[BreedImage], Error> {
        return repository.fetchBreedImagesBy(breed: value)
    }
}
