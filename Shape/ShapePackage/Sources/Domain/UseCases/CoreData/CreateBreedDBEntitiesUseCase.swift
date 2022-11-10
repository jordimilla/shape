import Foundation
import Combine

public struct CreateBreedDBEntitiesUseCase: CoreDataUseCase {
    typealias RequestValue = [Breed]
    let coreDataRepository: CoreDataRepository
    
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: [Breed]) {
        return coreDataRepository.createBreedDBEntities(breeds: value)
    }
}
