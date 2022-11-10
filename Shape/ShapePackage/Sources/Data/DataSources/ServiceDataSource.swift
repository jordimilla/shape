import Foundation
import Combine
import Domain

public struct ServiceDataSource: ServiceRepository {
    public init() {}
    
    public func fetchBreeds() -> AnyPublisher<[Breed], Error> {
        
        guard let url = URL(string: "https://dog.ceo/api/breeds/list") else {
            fatalError("Invalid URL")
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ data, response -> [Breed] in
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(Response<[String]>.self, from: data)
                return BreedMapper.map(input: response.message)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    public func fetchBreedImagesBy(breed: String) -> AnyPublisher<[BreedImage], Error> {
        guard let url = URL(string: "https://dog.ceo/api/breed/\(breed)/images") else {
            fatalError("Invalid URL")
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ data, response -> [BreedImage] in
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(Response<[String]>.self, from: data)
                return BreedImagesMapper.map(input: response.message)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
