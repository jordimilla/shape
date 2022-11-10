import Foundation
import Combine

public struct FetchBreedsFromStoredUseCase: CoreDataUseCase {
    typealias RequestValue = Void
    typealias ResponseValue = AnyPublisher<[BreedDB], Error>
    let coreDataRepository: CoreDataRepository
  
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: Void) -> AnyPublisher<[BreedDB], Error> {
        return coreDataRepository.fetchBreedFromStored()
    }
}
