import XCTest
@testable import EffectiveToDoList

class TodoDetailPresenterTests: XCTestCase {
    
    var sut: TodoDetailPresenterImpl!
    var mockView: MockTodoDetailView!
    var mockInteractor: MockTodoDetailInteractor!
    
    override func setUp() {
        super.setUp()
        mockView = MockTodoDetailView()
        mockInteractor = MockTodoDetailInteractor()
        
        sut = TodoDetailPresenterImpl(interactor: mockInteractor)
        sut.view = mockView
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockInteractor = nil
        super.tearDown()
    }
    
    func test_viewDidLoad_callsInteractorFetchTodo() {
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockInteractor.fetchTodoCalled, "Interactor.fetchTodo() должен быть вызван при загрузке view")
    }
    
    func test_todoEditingFinished_callsInteractorSaveTodo() {
        // Given
        let editedTodo = Todo(id: UUID(), title: "Updated Title", text: "", createDate: Date(), isCompleted: true)
        
        // When
        sut.todoEditingFinished(editedTodo)
        
        // Then
        XCTAssertTrue(mockInteractor.saveTodoCalled, "Interactor.saveTodo() должен быть вызван по завершении редактирования")
        XCTAssertEqual(mockInteractor.lastSavedTodo, editedTodo, "Интерактору должен быть передан правильный, отредактированный todo")
    }
    
    func test_showTodo_withValidTodo_tellsViewToShowData() {
        // Given
        let todoToShow = Todo(id: UUID(), title: "Show this", text: "", createDate: Date(), isCompleted: false)
        
        // When
        sut.showTodo(todoToShow)
        
        // Then
        XCTAssertTrue(mockView.showTodoCalled, "View.showTodo() должен быть вызван")
        XCTAssertNotNil(mockView.lastShownTodo, "View должен получить не nil объект")
        XCTAssertEqual(mockView.lastShownTodo, todoToShow, "View должен получить корректный todo от презентера")
    }
    
    func test_showTodo_withNilTodo_tellsViewToShowNil() {
        // Given
        // Это сценарий создания нового todo, когда исходных данных нет.
        
        // When
        sut.showTodo(nil)
        
        // Then
        XCTAssertTrue(mockView.showTodoCalled, "View.showTodo() должен быть вызван, даже если todo is nil")
        XCTAssertNil(mockView.lastShownTodo, "View должен получить nil, чтобы отобразить пустой экран для создания новой задачи")
    }
}
