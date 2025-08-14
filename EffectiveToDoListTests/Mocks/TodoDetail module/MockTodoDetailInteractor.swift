import XCTest
@testable import EffectiveToDoList

class MockTodoDetailInteractor: TodoDetailInteractor {
    var fetchTodoCalled = false
    var saveTodoCalled = false
    var lastSavedTodo: Todo?
    
    var todoToReturn: Todo?
    
    init(todoToReturn: Todo? = nil) {
        self.todoToReturn = todoToReturn
    }
    
    func fetchTodo() {
        fetchTodoCalled = true
    }
    
    func saveTodo(_ todo: Todo) {
        saveTodoCalled = true
        lastSavedTodo = todo
    }
}
