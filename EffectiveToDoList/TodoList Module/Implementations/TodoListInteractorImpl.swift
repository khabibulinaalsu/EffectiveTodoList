import Foundation

final class TodoListInteractorImpl: TodoListInteractor {
    
    weak var presenter: TodoListPresenter?
    
    private let dataManager: TodoDataProvider
    private let networkDataManager: TodoNetworkDataProvider
    
    private var loadFromApiIsNotNeeded: Bool
    
    private var searchText = ""
    
    init(dataManager: TodoDataProvider, networkDataManager: TodoNetworkDataProvider) {
        self.dataManager = dataManager
        self.networkDataManager = networkDataManager
        loadFromApiIsNotNeeded = UserDefaults.standard.bool(forKey: "loadFromApiIsNotNeeded")
    }
    
    func fetchTodolist() {
        if loadFromApiIsNotNeeded {
            dataManager.fetchTodos { [weak self] todolist in
                guard let self else { return }
                self.filter(todolist)
            }
        } else {
            networkDataManager.fetchTodos { [weak self] todolist in
                guard let self else { return }
                
                self.loadFromApiIsNotNeeded = true
                UserDefaults.standard.setValue(true, forKey: "loadFromApiIsNotNeeded")
                
                self.dataManager.createTodolist(todolist) {
                    self.fetchTodolist()
                }
            }
        }
    }
    
    func changeTodo(_ todo: Todo) {
        dataManager.updateTodo(todo) { [weak self] in
            self?.fetchTodolist()
        }
    }
    
    func deleteTodo(_ todo: Todo) {
        dataManager.deleteTodo(by: todo.id) { [weak self] in
            self?.fetchTodolist()
        }
    }
    
    func changeSearchText(_ searchText: String) {
        self.searchText = searchText
        fetchTodolist()
    }
    
    private func filter(_ todolist: TodoList) {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            
            if searchText.isEmpty {
                DispatchQueue.main.async {
                    self.presenter?.showTodolist(todolist)
                }
            }
            
            let searchWords = Set(searchText.lowercased().components(separatedBy: " "))
            
            let filteredTodolist = todolist.filter { todo in
                let todoText = "\(todo.text) \(todo.title)".lowercased()
                
                for word in searchWords {
                    if !word.isEmpty && !todoText.contains(word) {
                        return false
                    }
                }
                return true
            }
            
            DispatchQueue.main.async {
                self.presenter?.showTodolist(filteredTodolist)
            }
        }
    }
}
