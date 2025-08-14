import XCTest
@testable import EffectiveToDoList

class MockTodoDataProvider: TodoDataProvider {
    
    var createTodoCalled = false
    var createTodolistCalled = false
    var fetchTodosCalled = false
    var updateTodoCalled = false
    var deleteTodoCalled = false
    
    var lastCreatedTodo: Todo?
    var lastCreatedTodolist: TodoList?
    var lastUpdatedTodo: Todo?
    var lastDeletedTodoId: UUID?
    
    var todolistToReturn: TodoList = []
    
    func createTodo(_ todo: Todo, completion: @escaping () -> Void) {
        createTodoCalled = true
        lastCreatedTodo = todo
        completion()
    }
    
    func createTodolist(_ todolist: TodoList, completion: @escaping () -> Void) {
        createTodolistCalled = true
        lastCreatedTodolist = todolist
        completion()
    }
    
    func fetchTodos(completion: @escaping (TodoList) -> Void) {
        fetchTodosCalled = true
        // Вызываем completion с заранее подготовленными данными
        completion(todolistToReturn)
    }
    
    func updateTodo(_ todo: Todo, completion: @escaping () -> Void) {
        updateTodoCalled = true
        lastUpdatedTodo = todo
        completion()
    }
    
    func deleteTodo(by id: UUID, completion: @escaping () -> Void) {
        deleteTodoCalled = true
        lastDeletedTodoId = id
        completion()
    }
}
