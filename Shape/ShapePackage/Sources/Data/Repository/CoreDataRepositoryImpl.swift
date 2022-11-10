import Foundation
import Combine
import Domain
import CoreData

public struct CoreDataRepositoryImpl: CoreDataRepository {

    private let coreDataStore: CoreDataStoring

    public init(coreDataStore: CoreDataStoring) {
        self.coreDataStore = coreDataStore
    }
    
    public func createBreedDBEntities(breeds: [Breed]) {
        var cancellables = Set<AnyCancellable>()
        let action: Action = {
            for breed in breeds {
                let p: BreedDB = self.coreDataStore.createEntity()
                p.name = breed.name
            }
        }
        
        coreDataStore
            .publicher(save: action)
            .sink { completion in
            } receiveValue: { success in
            }
            .store(in: &cancellables)
    }
    
    public func fetchBreedFromStored() -> AnyPublisher<[BreedDB], Error> {
        let request = NSFetchRequest<BreedDB>(entityName: BreedDB.entityName)
        return coreDataStore
            .publicher(fetch: request)
            .tryMap { items in
                return items
            }
            .eraseToAnyPublisher()
    }
}
