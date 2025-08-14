import XCTest
@testable import EffectiveToDoList

class MockTodoDetailView: TodoDetailView {
    var showTodoCalled = false
    var lastShownTodo: Todo?
    
    func showTodo(_ todo: Todo?) {
        showTodoCalled = true
        lastShownTodo = todo
    }
}
