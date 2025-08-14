import XCTest
@testable import EffectiveToDoList

class MockTodoListPresenter: TodoListPresenter {
    
    var viewDidAppearCalled = false
    var todoChangedCalled = false
    var deleteTappedCalled = false
    var searchTextChangedCalled = false
    var selectedCalled = false
    var showTodolistCalled = false
    
    var lastChangedTodo: Todo?
    var lastDeletedTodo: Todo?
    var lastSearchText: String?
    var lastSelectedTodo: Todo?
    var lastSelectedFromView: UIViewController?
    var lastShownTodoList: TodoList?
    
    
    func viewDidAppear() {
        viewDidAppearCalled = true
    }
    
    func todoChanged(_ todo: Todo) {
        todoChangedCalled = true
        lastChangedTodo = todo
    }
    
    func deleteTapped(_ todo: Todo) {
        deleteTappedCalled = true
        lastDeletedTodo = todo
    }
    
    func searchTextChanged(_ searchText: String) {
        searchTextChangedCalled = true
        lastSearchText = searchText
    }
    
    func selected(_ todo: Todo?, from view: UIViewController) {
        selectedCalled = true
        lastSelectedTodo = todo
        lastSelectedFromView = view
    }
    
    func showTodolist(_ todolist: TodoList) {
        showTodolistCalled = true
        lastShownTodoList = todolist
    }
}
