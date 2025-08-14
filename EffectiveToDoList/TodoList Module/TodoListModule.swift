import UIKit

enum TodoListModule {
    
    static func buildTodoList() -> UIViewController {
        let router = TodoListRouterImpl()
        let interactor = TodoListInteractorImpl(
            dataManager: TodoCoreDataManager.shared,
            networkDataManager: TodoNetworkManager.shared
        )
        let presenter = TodoListPresenterImpl(interactor: interactor, router: router)
        let view = TodoListViewImpl(presenter: presenter)
        
        interactor.presenter = presenter
        presenter.view = view
        
        return view
    }
    
}
