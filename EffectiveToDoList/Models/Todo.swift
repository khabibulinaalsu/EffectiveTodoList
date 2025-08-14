import Foundation

struct Todo: Equatable {
    let id: UUID
    var title: String
    var text: String
    let createDate: Date
    var isCompleted: Bool
}

extension Todo {
    init(entity: TodoEntity) {
        id = entity.uuid ?? UUID()
        title = entity.title ?? ""
        text = entity.text ?? ""
        createDate = entity.createDate ?? Date()
        isCompleted = entity.isCompleted
    }
    
    init(dto: TodoDTO) {
        id = UUID()
        title = "New task"
        text = dto.todo
        createDate = Date()
        isCompleted = dto.completed
    }
}

