import Foundation
import Combine

public struct FetchBreedsUseCase: ServiceUseCase {
    typealias RequestValue = Void
    typealias ResponseValue = AnyPublisher<[Breed], Error>
    let repository: ServiceRepository
    
    public init(repository: ServiceRepository) {
        self.repository = repository
    }
    
    public func execute(value: Void) -> AnyPublisher<[Breed], Error> {
        return repository.fetchBreeds()
    }
}
