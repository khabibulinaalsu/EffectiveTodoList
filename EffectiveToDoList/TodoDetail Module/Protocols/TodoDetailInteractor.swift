import Foundation

protocol TodoDetailInteractor: AnyObject {
    func fetchTodo()
    func saveTodo(_ todo: Todo)
}
