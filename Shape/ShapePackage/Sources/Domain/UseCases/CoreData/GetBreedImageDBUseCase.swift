import Foundation
import Combine

public struct GetBreedImageDBUseCase: CoreDataUseCase {
    typealias RequestValue = String
    typealias ResponseValue = AnyPublisher<BreedImageDB, Error>
    let coreDataRepository: CoreDataRepository
  
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: String) -> AnyPublisher<BreedImageDB, Error> {
        return coreDataRepository.getBreedImageDB(imageUrl: value)
    }
}


