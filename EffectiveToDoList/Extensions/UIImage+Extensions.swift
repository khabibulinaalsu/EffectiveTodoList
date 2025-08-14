import UIKit

extension UIImage {
    static var completed: UIImage? {
        UIImage(systemName: "checkmark.circle")
    }
    
    static var uncompleted: UIImage? {
        UIImage(systemName: "circle")
    }
    
    static var search: UIImage? {
        UIImage(systemName: "magnifyingglass")?
            .withTintColor(.systemGray)
            .withRenderingMode(.alwaysOriginal)
    }
    
    static var searchMicrophone: UIImage? {
        UIImage(systemName: "mic.fill")?
            .withTintColor(.systemGray)
            .withRenderingMode(.alwaysOriginal)
    }
    
    static var addTodo: UIImage? {
        UIImage(systemName: "square.and.pencil")?.withTintColor(.systemYellow)
    }
    
    static var share: UIImage? {
        UIImage(systemName: "square.and.arrow.up")
    }
    
    static var delete: UIImage? {
        UIImage(systemName: "trash")
    }
}
