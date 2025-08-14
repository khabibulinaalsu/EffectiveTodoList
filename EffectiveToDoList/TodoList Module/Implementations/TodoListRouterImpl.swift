import UIKit

final class TodoListRouterImpl: TodoListRouter {
    func goToTodoDetail( _ todo: Todo?, from view: UIViewController) {
        let todoDetailVC = TodoDetailModule.buildTodoDetail(with: todo)
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        backButton.tintColor = .systemYellow
        view.navigationItem.backBarButtonItem = backButton
        
        view.navigationController?.pushViewController(todoDetailVC, animated: true)
        
    }
}
