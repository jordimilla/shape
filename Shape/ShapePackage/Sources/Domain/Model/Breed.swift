import Foundation

public struct Breed: Decodable, Encodable {
    public var name: String
    
    public init(name: String) {
        self.name = name
    }
}
