import Foundation
import Combine
import CoreData
@testable import Domain

struct MockCoreDataRepository: CoreDataRepository {
    func createBreedDBEntities(breeds: [Breed]) {
        
    }
    
    func createBreedImagesDBEntities(breedImages: [BreedImage]) {
        
    }
    
    func fetchBreedFromStored() -> AnyPublisher<[BreedDB], Error> {
        return Just([BreedDB()])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchBreedImagesFromStoredBy(breed: String) -> AnyPublisher<[BreedImageDB], Error> {
        return Just([BreedImageDB()])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchFavoritesFromStored() -> AnyPublisher<[BreedImageDB], Error> {
        return Just([BreedImageDB()])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getBreedImageDB(imageUrl: String) -> AnyPublisher<BreedImageDB, Error> {
        return Just(BreedImageDB())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func updateFavoriteImage(image: BreedImageDB) -> AnyPublisher<Bool, Error> {
        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}
