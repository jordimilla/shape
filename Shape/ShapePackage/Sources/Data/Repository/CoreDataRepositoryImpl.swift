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
                let b: BreedDB = self.coreDataStore.createEntity()
                b.name = breed.name
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
    
    public func createBreedImagesDBEntities(breedImages: [BreedImage]) {
        var cancellables = Set<AnyCancellable>()
        let action: Action = {
            for breed in breedImages {
                let b: BreedImageDB = self.coreDataStore.createEntity()
                b.breed = breed.breed ?? ""
                b.imageUrl = breed.imageUrl
                b.hasFavorite = breed.hasFavorite ?? false
            }
        }
        
        coreDataStore
            .publicher(save: action)
            .sink { completion in
            } receiveValue: { success in
            }
            .store(in: &cancellables)
    }
    
    public func fetchBreedImagesFromStoredBy(breed: String) -> AnyPublisher<[BreedImageDB], Error> {
        let request = NSFetchRequest<BreedImageDB>(entityName: BreedImageDB.entityName)
        request.predicate = NSPredicate(format: "breed == %@", breed)
        return coreDataStore
            .publicher(fetch: request)
            .tryMap { items in
                return items
            }
            .eraseToAnyPublisher()
    }
    
    public func fetchFavoritesFromStored() -> AnyPublisher<[BreedImageDB], Error> {
        let request = NSFetchRequest<BreedImageDB>(entityName: BreedImageDB.entityName)
        request.predicate = NSPredicate(format: "hasFavorite == YES")
        return coreDataStore
            .publicher(fetch: request)
            .tryMap { items in
                return items
            }
            .eraseToAnyPublisher()
    }
    
    public func updateFavoriteImage(image: BreedImageDB) -> AnyPublisher<Bool, Error> {
        let action : Action = {
            image.setValue(!image.hasFavorite, forKey: "hasFavorite")
        }
        
        return coreDataStore
            .publicher(save: action)
            .tryMap { items in
                return items
            }
            .eraseToAnyPublisher()
    }
    
    public func getBreedImageDB(imageUrl: String) -> AnyPublisher<BreedImageDB, Error> {
        let request = NSFetchRequest<BreedImageDB>(entityName: BreedImageDB.entityName)
        request.predicate = NSPredicate(format: "imageUrl == %@", imageUrl)
        return coreDataStore
            .publicher(fetch: request)
            .tryMap { items in
                guard let post: BreedImageDB = items.first else { return BreedImageDB()}
                return post
            }
            .eraseToAnyPublisher()
    }
}
