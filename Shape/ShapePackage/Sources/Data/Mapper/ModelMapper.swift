import Foundation
import Domain

public struct BreedMapper: Mapper {
    
    static public func map(input: [String]) -> [Breed] {
        return input.map { countK -> Breed in
            Breed(name: countK)
        }
    }
}

public struct BreedImagesMapper: Mapper {
    
    static public func map(input: [String]) -> [BreedImage] {
        return input.map { countK -> Breed in
            BreedImage(imageUrl: countK)
        }
    }
}
