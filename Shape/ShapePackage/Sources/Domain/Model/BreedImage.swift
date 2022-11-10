import Foundation

public struct BreedImage: Decodable, Encodable {
    public var imageUrl: String
    
    public init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}
