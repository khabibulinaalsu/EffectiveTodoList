import Foundation

final class TodoNetworkManager: TodoNetworkDataProvider {
    
    static let shared = TodoNetworkManager()
    
    private init() { }
    
    func fetchTodos(completion: @escaping (TodoList) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            completion([])
            return
        }
         
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data else { return }
            
            let decoder = JSONDecoder()
            do {
                let todoList = try decoder.decode(TodoListDTO.self, from: data)
                DispatchQueue.main.async {
                    completion(todoList.asTodoList)
                }
            } catch {
                // TODO: error handle
            }
        }
        task.resume()
    }
}
