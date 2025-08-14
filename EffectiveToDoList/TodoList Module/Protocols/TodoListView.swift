import Foundation

protocol TodoListView: AnyObject {
    func reload()
    func showTodoList(_ todos: TodoList)
}

