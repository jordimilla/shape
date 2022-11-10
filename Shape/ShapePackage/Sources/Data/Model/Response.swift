import Foundation

public struct Response<T: Codable>: Codable {
    // MARK: - Properties
    public let message: T
    
    public init(message: T) {
        self.message = items
    }
    
    private enum CodingKeys: String, CodingKey {
        case message
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(T.self, forKey: .items)
    }
}
