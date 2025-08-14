import Foundation

protocol TodoDetailPresenter: AnyObject {
    func viewDidLoad()
    func todoEditingFinished(_ todo: Todo)
    func showTodo(_ todo: Todo?)
}
