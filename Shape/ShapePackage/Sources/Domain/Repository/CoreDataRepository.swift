import Foundation
import Combine
import CoreData

public protocol CoreDataRepository {
    func createBreedDBEntities(breeds: [Breed])
    func fetchBreedFromStored() -> AnyPublisher<[BreedDB], Error>
}
