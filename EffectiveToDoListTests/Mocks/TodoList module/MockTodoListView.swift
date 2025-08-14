import XCTest
@testable import EffectiveToDoList

class MockTodoListView: TodoListView {
    var reloadCalled = false
    var showTodoListCalled = false
    var lastShownTodoList: TodoList?
    
    func reload() {
        reloadCalled = true
    }
    
    func showTodoList(_ todos: TodoList) {
        showTodoListCalled = true
        lastShownTodoList = todos
    }
}
