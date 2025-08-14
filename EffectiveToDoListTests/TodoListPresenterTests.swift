import XCTest
@testable import EffectiveToDoList

class TodoListPresenterTests: XCTestCase {
    
    var sut: TodoListPresenterImpl!
    var mockView: MockTodoListView!
    var mockInteractor: MockTodoListInteractor!
    var mockRouter: MockTodoListRouter!
    
    override func setUp() {
        super.setUp()
        mockView = MockTodoListView()
        mockInteractor = MockTodoListInteractor()
        mockRouter = MockTodoListRouter()
        
        // System Under Test (SUT)
        sut = TodoListPresenterImpl(interactor: mockInteractor, router: mockRouter)
        sut.view = mockView
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func test_viewDidAppear_callsInteractorFetch() {
        // When
        sut.viewDidAppear()
        
        // Then
        XCTAssertTrue(mockInteractor.fetchTodolistCalled, "Interactor.fetchTodolist() должен быть вызван при появлении view")
    }
    
    func test_showTodoList_tellsViewToShowData() {
        // Given
        let existingTodo = Todo(id: UUID(), title: "Existing", text: "", createDate: Date(), isCompleted: true)
        let todos = [existingTodo]
        
        // When
        sut.showTodolist(todos)
        
        // Then
        XCTAssertTrue(mockView.showTodoListCalled, "View.showTodoList() должен быть вызван")
        XCTAssertEqual(mockView.lastShownTodoList, todos, "Презентер должен передать корректные данные во View")
    }
    
    func test_deleteTapped_callsInteractorDelete() {
        // Given
        let todoToDelete = Todo(id: UUID(), title: "To delete", text: "", createDate: Date(), isCompleted: true)
        
        // When
        sut.deleteTapped(todoToDelete)
        
        // Then
        XCTAssertTrue(mockInteractor.deleteTodoCalled, "Interactor.deleteTodo() должен быть вызван")
        XCTAssertEqual(mockInteractor.lastDeletedTodo, todoToDelete, "Презентер должен передать правильный todo для удаления")
    }
    
    func test_searchTextChanged_callsInteractorChangeSearchText() {
        // Given
        let searchText = "find me"
        
        // When
        sut.searchTextChanged(searchText)
        
        // Then
        XCTAssertTrue(mockInteractor.changeSearchTextCalled)
        XCTAssertEqual(mockInteractor.lastSearchText, searchText)
    }
    
    func test_selectedTodo_callsRouterGoToDetail() {
        // Given
        let selectedTodo = Todo(id: UUID(), title: "Selected", text: "", createDate: Date(), isCompleted: false)
        let mockViewController = UIViewController()
        
        // When
        sut.selected(selectedTodo, from: mockViewController)
        
        // Then
        XCTAssertTrue(mockRouter.goToTodoDetailCalled, "Router.goToTodoDetail() должен быть вызван")
        XCTAssertEqual(mockRouter.passedTodo, selectedTodo, "Роутер должен получить правильный todo для перехода")
        XCTAssertEqual(mockRouter.passedFromView, mockViewController)
    }
}
