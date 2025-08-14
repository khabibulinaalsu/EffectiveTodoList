import Foundation

protocol TodoDataProvider {
    func createTodo(_ todo: Todo, completion: @escaping () -> Void)
    func createTodolist(_ todolist: TodoList, completion: @escaping () -> Void)
    func fetchTodos(completion: @escaping (TodoList) -> Void)
    func updateTodo(_ todo: Todo, completion: @escaping () -> Void)
    func deleteTodo(by id: UUID, completion: @escaping () -> Void)
}


