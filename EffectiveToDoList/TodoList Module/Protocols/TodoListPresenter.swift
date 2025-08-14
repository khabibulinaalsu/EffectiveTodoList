import UIKit

protocol TodoListPresenter: AnyObject {
    func viewDidAppear()
    func todoChanged(_ todo: Todo)
    func deleteTapped(_ todo: Todo)
    func searchTextChanged(_ searchText: String)
    
    func selected(_ todo: Todo?, from view: UIViewController)

    func showTodolist(_ todolist: TodoList)
}

extension TodoListPresenter {
    func selected(from view: UIViewController) {
        selected(nil, from: view)
    }
    
}
