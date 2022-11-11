import Foundation
import Combine

public struct CreateBreedImagesDBEntitiesUseCase: CoreDataUseCase {
    typealias RequestValue = [BreedImage]
    let coreDataRepository: CoreDataRepository
    
    public init(coreDataRepository: CoreDataRepository) {
        self.coreDataRepository = coreDataRepository
    }
    
    public func execute(value: [BreedImage]) {
        return coreDataRepository.createBreedImagesDBEntities(breedImages: value)
    }
}
