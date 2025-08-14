import Foundation

struct TodoDTO: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

extension TodoDTO {
    var asTodo: Todo { Todo(dto: self) }
}
