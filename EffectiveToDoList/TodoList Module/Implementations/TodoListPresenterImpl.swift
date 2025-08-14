import UIKit

final class TodoListPresenterImpl: TodoListPresenter {
    
    var interactor: TodoListInteractor
    var router: TodoListRouter
    weak var view: TodoListView?
    
    init(interactor: TodoListInteractor, router: TodoListRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    
    func viewDidAppear() {
        interactor.fetchTodolist()
    }
    
    func todoChanged(_ todo: Todo) {
        interactor.changeTodo(todo)
    }
    
    func deleteTapped(_ todo: Todo) {
        interactor.deleteTodo(todo)
    }
    
    func searchTextChanged(_ searchText: String) {
        interactor.changeSearchText(searchText)
    }
    
    func selected(_ todo: Todo?, from view: UIViewController) {
        router.goToTodoDetail(todo, from: view)
    }
    
    func showTodolist(_ todolist: TodoList) {
        view?.showTodoList(todolist)
    }
}
