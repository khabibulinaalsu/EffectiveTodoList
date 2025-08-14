import Foundation

struct TodoListDTO: Decodable {
    let todos: [TodoDTO]
}

extension TodoListDTO {
    var asTodoList: TodoList { todos.map(\.asTodo) }
}
