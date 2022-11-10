import Foundation
import CoreData

public struct Breed: Decodable, Encodable {
    public var name: String
    
    public init(name: String) {
        self.name = name
    }
}

@objc(BreedDB)
public class BreedDB: NSManagedObject {

}

extension BreedDB {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<BreedDB> {
        return NSFetchRequest<BreedDB>(entityName: "BreedDB")
    }

    @NSManaged public var name: String
    
    static public func mapBreeds(input: [BreedDB]) -> [Breed] {
        return input.map { breed -> Breed in
            Breed(name: breed.name)
        }
    }
}
