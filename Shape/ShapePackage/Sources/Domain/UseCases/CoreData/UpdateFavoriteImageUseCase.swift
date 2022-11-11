import Foundation
import Combine
import CoreData

public struct UpdateFavoriteImageUseCase: CoreDataUseCase {
    typealias RequestValue = BreedImageDB
    typealias ResponseValue = AnyPublisher<Bool, Error>
    let coreDataRepository: CoreDataRepository
  
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: BreedImageDB) -> AnyPublisher<Bool, Error> {
        return coreDataRepository.updateFavoriteImage(image: value)
    }
}
