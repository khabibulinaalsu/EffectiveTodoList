import XCTest
@testable import EffectiveToDoList

class TodoListInteractorTests: XCTestCase {
    
    var sut: TodoListInteractorImpl!
    var mockPresenter: MockTodoListPresenter!
    var mockDataService: MockTodoDataProvider!
    var mockNetworkService: MockTodoNetworkDataProvider!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockTodoListPresenter()
        mockDataService = MockTodoDataProvider()
        mockNetworkService = MockTodoNetworkDataProvider()
        
        sut = TodoListInteractorImpl(
            dataManager: mockDataService,
            networkDataManager: mockNetworkService
        )
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        sut = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func test_fetchTodolist_whenDataExists_callsPresenterShowTodo() {
        // Given
        let existingTodo = Todo(id: UUID(), title: "Existing", text: "", createDate: Date(), isCompleted: true)
        mockDataService = MockTodoDataProvider()
        mockDataService.todolistToReturn = [existingTodo]
        
        // When
        sut.fetchTodolist()
        
        // Then
        XCTAssertTrue(mockPresenter.showTodolistCalled, "Presenter.showTodolist() должен быть вызван после успешного получения данных")
        XCTAssertNotNil(mockPresenter.lastShownTodoList, "Презентер должен получить непустые данные")
    }
    
    func test_deleteTodo_whenSuccessful_callsFetchTodolist() {
        // Given
        let todoToDelete = Todo(id: UUID(), title: "To delete", text: "", createDate: Date(), isCompleted: true)
        
        // When
        sut.deleteTodo(todoToDelete)
        
        // Then
        XCTAssertTrue(mockPresenter.showTodolistCalled, "Presenter.showTodolist() должен быть вызван с обновленным списком")
    }
}
