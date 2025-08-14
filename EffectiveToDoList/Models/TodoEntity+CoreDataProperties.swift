import Foundation
import CoreData


extension TodoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoEntity> {
        return NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
    }

    @NSManaged public var createDate: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var uuid: UUID?

}

extension TodoEntity : Identifiable {

}
