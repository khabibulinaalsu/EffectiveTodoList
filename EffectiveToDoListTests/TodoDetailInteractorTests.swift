import XCTest
@testable import EffectiveToDoList

class TodoDetailInteractorTests: XCTestCase {
    
    var sut: TodoDetailInteractorImpl!
    var mockPresenter: MockTodoDetailPresenter!
    var mockDataService: MockTodoDataProvider!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockTodoDetailPresenter()
        mockDataService = MockTodoDataProvider()
    }
    
    override func tearDown() {
        sut = nil
        mockPresenter = nil
        mockDataService = nil
        super.tearDown()
    }
    
    func test_fetchTodo_whenTodoExists_callsPresenterWithTodo() {
        // Given
        let existingTodo = Todo(id: UUID(), title: "Existing", text: "", createDate: Date(), isCompleted: true)
        // Инициализируем интерактор с существующим todo. Это частый паттерн для detail-экранов.
        sut = TodoDetailInteractorImpl(todo: existingTodo, dataManager: mockDataService)
        sut.presenter = mockPresenter
        
        // When
        sut.fetchTodo()
        
        // Then
        XCTAssertTrue(mockPresenter.showTodoCalled, "Presenter.showTodo() должен быть вызван")
        XCTAssertEqual(mockPresenter.lastShownTodo, existingTodo, "Презентер должен получить тот же todo, с которым был инициализирован интерактор")
    }
    
    func test_fetchTodo_whenCreatingNew_callsPresenterWithNil() {
        // Given
        // Инициализируем интерактор без todo (сценарий создания новой задачи).
        sut = TodoDetailInteractorImpl(todo: nil, dataManager: mockDataService)
        sut.presenter = mockPresenter
        
        // When
        sut.fetchTodo()
        
        // Then
        XCTAssertTrue(mockPresenter.showTodoCalled, "Presenter.showTodo() должен быть вызван")
        XCTAssertNil(mockPresenter.lastShownTodo, "Презентер должен получить nil при создании новой задачи")
    }
    
    func test_saveTodo_callsDataService() {
        // Given
        sut = TodoDetailInteractorImpl(todo: nil, dataManager: mockDataService)
        sut.presenter = mockPresenter
        
        let newTodo = Todo(id: UUID(), title: "New", text: "", createDate: Date(), isCompleted: true)
        
        // When
        sut.saveTodo(newTodo)
        
        // Then
        XCTAssertTrue(mockDataService.createTodoCall.called)
        XCTAssertEqual(mockDataService.createTodoCall.todo, newTodo)
    }
}
