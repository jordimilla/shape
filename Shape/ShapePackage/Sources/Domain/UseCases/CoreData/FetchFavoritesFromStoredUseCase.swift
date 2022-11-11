import Foundation
import Combine

public struct FetchFavoritesFromStoredUseCase: CoreDataUseCase {
    typealias RequestValue = Void
    typealias ResponseValue = AnyPublisher<[BreedImageDB], Error>
    let coreDataRepository: CoreDataRepository
  
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: Void) -> AnyPublisher<[BreedImageDB], Error> {
        return coreDataRepository.fetchFavoritesFromStored()
    }
}
