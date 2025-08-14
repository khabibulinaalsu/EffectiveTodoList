import Foundation
import CoreData

final class TodoCoreDataManager: TodoDataProvider {
    
    static let shared = TodoCoreDataManager()
    
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Todo")
        container.loadPersistentStores { _, error in
            if let error {
                // TODO: error handle
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    private var context: NSManagedObjectContext {
        Self.persistentContainer.viewContext
    }

    func createTodo(_ todo: Todo, completion: @escaping () -> Void) {
        Self.persistentContainer.performBackgroundTask { [weak self] backgroundContext in
            guard let self else { return }
            
            let todoEntity = TodoEntity(context: backgroundContext)
            todoEntity.uuid = todo.id
            todoEntity.title = todo.title
            todoEntity.text = todo.text
            todoEntity.createDate = todo.createDate
            todoEntity.isCompleted = todo.isCompleted
            
            saveContext(backgroundContext)
            saveContext(context)
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func createTodolist(_ todolist: TodoList, completion: @escaping () -> Void) {
        Self.persistentContainer.performBackgroundTask { [weak self] backgroundContext in
            guard let self else { return }
            
            for todo in todolist {
                let todoEntity = TodoEntity(context: backgroundContext)
                todoEntity.uuid = todo.id
                todoEntity.title = todo.title
                todoEntity.text = todo.text
                todoEntity.createDate = todo.createDate
                todoEntity.isCompleted = todo.isCompleted
            }
            
            saveContext(backgroundContext)
            saveContext(context)
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func fetchTodos(completion: @escaping (TodoList) -> Void) {
        
        Self.persistentContainer.performBackgroundTask { [weak self] backgroundContext in
            let request = NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
            
            request.sortDescriptors = [NSSortDescriptor(key: "createDate", ascending: false)]
            
            do {
                let todoEntities = try backgroundContext.fetch(request)
                let objectIDs = todoEntities.map { $0.objectID }
                
                DispatchQueue.main.async {
                    let items = objectIDs.compactMap {
                        (self?.context.object(with: $0) as? TodoEntity).flatMap(Todo.init(entity:))
                    }
                    
                    completion(items)
                }
            } catch {
                // TODO: error handle
                print("Error fetching todos: \(error)")
            }
        }
    }
    
    func updateTodo(_ todo: Todo, completion: @escaping () -> Void) {
        Self.persistentContainer.performBackgroundTask { [weak self] backgroundContext in
            guard let self else { return }
            let request = NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
            request.predicate = NSPredicate(format: "uuid == %@", todo.id as CVarArg)
            
            do {
                let todoEntities = try backgroundContext.fetch(request)
                guard let todoEntity = todoEntities.first else {
                    DispatchQueue.main.async {
                        self.createTodo(todo, completion: completion)
                    }
                    return
                }
                todoEntity.title = todo.title
                todoEntity.text = todo.text
                todoEntity.createDate = todo.createDate
                todoEntity.isCompleted = todo.isCompleted
            } catch {
                print("Error updating todo: \(error)")
            }
            
            saveContext(backgroundContext)
            saveContext(context)
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func deleteTodo(by id: UUID, completion: @escaping () -> Void) {
        Self.persistentContainer.performBackgroundTask { [weak self] backgroundContext in
            guard let self else { return }
            let request = NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
            request.predicate = NSPredicate(format: "uuid == %@", id as CVarArg)
            
            do {
                let todoEntities = try backgroundContext.fetch(request)
                guard let todoEntity = todoEntities.first else {
                    // TODO: error handle
                    return
                }
                
                backgroundContext.delete(todoEntity)
            } catch {
                // TODO: error handle
                print("Error deleting todo: \(error)")
            }
            
            saveContext(backgroundContext)
            saveContext(context)
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    private func saveContext(_ context: NSManagedObjectContext) {
        context.performAndWait {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    context.rollback()
                }
            }
            context.reset()
        }
    }
}
