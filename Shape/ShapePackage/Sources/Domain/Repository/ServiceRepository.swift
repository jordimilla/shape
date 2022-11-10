import Foundation
import Combine

public protocol ServiceRepository {
    func fetchBreeds() -> AnyPublisher<[Breed], Error>
    func fetchBreedImagesBy(breed: String) -> AnyPublisher<[BreedImage], Error>
}
