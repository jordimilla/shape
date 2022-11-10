import Foundation

public struct BreedImage: Decodable, Encodable {
    public var imageUrl: String
    public var hasFavorite: Bool?
    
    public init(imageUrl: String, hasFavorite: Bool? = false) {
        self.imageUrl = imageUrl
        self.hasFavorite = hasFavorite
    }
}
