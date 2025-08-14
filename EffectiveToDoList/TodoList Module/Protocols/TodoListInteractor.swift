import Foundation

protocol TodoListInteractor: AnyObject {
    func fetchTodolist()
    func changeTodo(_ todo: Todo)
    func deleteTodo(_ todo: Todo)
    func changeSearchText(_ searchText: String)
}
