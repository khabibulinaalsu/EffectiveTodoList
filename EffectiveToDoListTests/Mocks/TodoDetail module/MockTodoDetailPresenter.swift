import XCTest
@testable import EffectiveToDoList

class MockTodoDetailPresenter: TodoDetailPresenter {
    var viewDidLoadCalled = false
    var todoEditingFinishedCalled = false
    var lastFinishedTodo: Todo?
    var showTodoCalled = false
    var lastShownTodo: Todo?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func todoEditingFinished(_ todo: Todo) {
        todoEditingFinishedCalled = true
        lastFinishedTodo = todo
    }
    
    func showTodo(_ todo: Todo?) {
        showTodoCalled = true
        lastShownTodo = todo
    }
}
