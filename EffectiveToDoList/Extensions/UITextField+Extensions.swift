import UIKit

extension UITextField {
    
    func setLeftPaddingPoints(left: CGFloat = 0, right: CGFloat = 0) {
        let paddingView = UIView()
        
        if let leftView {
            paddingView.addSubview(leftView)
            paddingView.frame = leftView.frame.inset(by: UIEdgeInsets(top: 0, left: -left, bottom: 0, right: -right))
            leftView.frame.origin.x += left
        }
        
        leftView = paddingView
    }
    
    func setRightPaddingPoints(left: CGFloat = 0, right: CGFloat = 0) {
        let paddingView = UIView()
        
        if let rightView {
            paddingView.addSubview(rightView)
            paddingView.frame = rightView.frame.inset(by: UIEdgeInsets(top: 0, left: -left, bottom: 0, right: -right))
        }
        
        rightView = paddingView
    }
    
}
