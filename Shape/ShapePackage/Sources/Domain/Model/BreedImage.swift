import Foundation
import CoreData

public struct BreedImage: Decodable, Encodable {
    public var imageUrl: String
    public var hasFavorite: Bool?
    public var breed: String?
    
    public init(imageUrl: String, hasFavorite: Bool? = false, breed: String? = "") {
        self.imageUrl = imageUrl
        self.hasFavorite = hasFavorite
        self.breed = breed
    }
}

@objc(BreedImageDB)
public class BreedImageDB: NSManagedObject {

}

extension BreedImageDB {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<BreedImageDB> {
        return NSFetchRequest<BreedImageDB>(entityName: "BreedImageDB")
    }

    @NSManaged public var imageUrl: String
    @NSManaged public var hasFavorite: Bool
    @NSManaged public var breed: String
    
    static public func mapBreedImage(input: [BreedImageDB]) -> [BreedImage] {
        return input.map { breedImage -> BreedImage in
            BreedImage(imageUrl: breedImage.imageUrl,
                       hasFavorite: breedImage.hasFavorite,
                       breed: breedImage.breed)
        }
    }
}

extension Collection where Element: Hashable {
    var orderedSet: [Element] {
        var set: Set<Element> = []
        return reduce(into: []){ set.insert($1).inserted ? $0.append($1) : ()  }
    }
}
