import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, indexPath: IndexPath) -> T {
        let id = String(describing: cellType)
        register(cellType, forCellReuseIdentifier: id)
        return dequeueReusableCell(withIdentifier: id, for: indexPath) as? T ?? T()
    }
}
