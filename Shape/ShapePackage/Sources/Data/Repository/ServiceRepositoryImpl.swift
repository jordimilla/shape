import Foundation
import Combine
import Domain

public struct ServiceRepositoryImpl: ServiceRepository {
    
    private let serviceDataSource: ServiceDataSource
    
    public init(serviceDataSource: ServiceDataSource) {
        self.serviceDataSource = serviceDataSource
    }
    
    public func fetchBreeds() -> AnyPublisher<[Breed], Error> {
        serviceDataSource.fetchBreeds()
    }
    
    public func fetchBreedImagesBy(breed: String) -> AnyPublisher<[BreedImage], Error> {
        serviceDataSource.fetchBreedImagesBy(breed: breed)
    }
}

