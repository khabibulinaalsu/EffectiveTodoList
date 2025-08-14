import Foundation

protocol TodoNetworkDataProvider {
    func fetchTodos(completion: @escaping (TodoList) -> Void)
}
