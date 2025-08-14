import XCTest
@testable import EffectiveToDoList

class MockTodoListInteractor: TodoListInteractor {
    var fetchTodolistCalled = false
    var changeTodoCalled = false
    var lastChangedTodo: Todo?
    var deleteTodoCalled = false
    var lastDeletedTodo: Todo?
    var changeSearchTextCalled = false
    var lastSearchText: String?
    
    func fetchTodolist() {
        fetchTodolistCalled = true
    }
    
    func changeTodo(_ todo: Todo) {
        changeTodoCalled = true
        lastChangedTodo = todo
    }
    
    func deleteTodo(_ todo: Todo) {
        deleteTodoCalled = true
        lastDeletedTodo = todo
    }
    
    func changeSearchText(_ searchText: String) {
        changeSearchTextCalled = true
        lastSearchText = searchText
    }
}
