import XCTest
@testable import EffectiveToDoList

class MockTodoNetworkDataProvider: TodoNetworkDataProvider {
    
    var fetchTodosCalled: Bool = false
    
    var todosToReturn: TodoList = []
    
    func fetchTodos(completion: @escaping (TodoList) -> Void) {
        fetchTodosCalled = true
        completion(todosToReturn)
    }
}
