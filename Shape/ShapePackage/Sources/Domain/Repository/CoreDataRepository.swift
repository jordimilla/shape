import Foundation
import Combine
import CoreData

public protocol CoreDataRepository {
    func createBreedDBEntities(breeds: [Breed])
    func createBreedImagesDBEntities(breedImages: [BreedImage])
    
    func fetchBreedFromStored() -> AnyPublisher<[BreedDB], Error>
    func fetchBreedImagesFromStoredBy(breed: String) -> AnyPublisher<[BreedImageDB], Error>
    
    func fetchFavoritesFromStored() -> AnyPublisher<[BreedImageDB], Error>
    
    func getBreedImageDB(imageUrl: String) -> AnyPublisher<BreedImageDB, Error>
    
    func updateFavoriteImage(image: BreedImageDB) -> AnyPublisher<Bool, Error>
}
