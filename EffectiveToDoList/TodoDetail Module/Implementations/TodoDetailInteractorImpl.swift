import Foundation

final class TodoDetailInteractorImpl: TodoDetailInteractor {
    
    weak var presenter: TodoDetailPresenter?
    private var todo: Todo?
    private let dataManager: TodoDataProvider
    
    init(todo: Todo?, dataManager: TodoDataProvider) {
        self.todo = todo
        self.dataManager = dataManager
    }
    
    func fetchTodo() {
        presenter?.showTodo(todo)
    }
    
    func saveTodo(_ todo: Todo) {
        if todo.title.isEmpty {
            // TODO: показывать ворнинг
            return
        }
        dataManager.updateTodo(todo) { }
    }
    
}
