import XCTest
@testable import EffectiveToDoList

class MockTodoListRouter: TodoListRouter {
    var goToTodoDetailCalled = false
    var passedTodo: Todo?
    var passedFromView: UIViewController?
    
    func goToTodoDetail(_ todo: Todo?, from view: UIViewController) {
        goToTodoDetailCalled = true
        passedTodo = todo
        passedFromView = view
    }
}
