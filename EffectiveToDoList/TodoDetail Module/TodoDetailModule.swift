import UIKit

enum TodoDetailModule {
    
    static func buildTodoDetail(with todo: Todo?) -> UIViewController {
        let interactor = TodoDetailInteractorImpl(todo: todo, dataManager: TodoCoreDataManager.shared)
        let presenter = TodoDetailPresenterImpl(interactor: interactor)
        let view = TodoDetailViewImpl(presenter: presenter)
        
        interactor.presenter = presenter
        presenter.view = view
        
        return view
    }
}
