import UIKit

protocol TodoListRouter {
    func goToTodoDetail(_ todo: Todo?, from view: UIViewController)
}
