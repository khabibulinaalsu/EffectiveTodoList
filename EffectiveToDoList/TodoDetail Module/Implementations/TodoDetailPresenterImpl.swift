import Foundation

final class TodoDetailPresenterImpl: TodoDetailPresenter {
    
    var interactor: TodoDetailInteractor
    weak var view: TodoDetailView?
    
    init(interactor: TodoDetailInteractor) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.fetchTodo()
    }
    
    func todoEditingFinished(_ todo: Todo) {
        interactor.saveTodo(todo)
    }
    
    func showTodo(_ todo: Todo?) {
        view?.showTodo(todo)
    }
    
    
}
