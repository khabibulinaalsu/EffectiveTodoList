import UIKit

extension UILabel {
    func cellTitleStyle() {
        font = .systemFont(ofSize: 16, weight: .medium)
        numberOfLines = 0
    }
    
    func cellDescriptionStyle() {
        font = .systemFont(ofSize: 12, weight: .regular)
        numberOfLines = 0
    }
    
    func dateStyle() {
        font = .systemFont(ofSize: 12, weight: .regular)
        numberOfLines = 0
        opacity(0.5)
    }
    
    func countStyle() {
        textAlignment = .center
        font = .systemFont(ofSize: 11, weight: .regular)
        numberOfLines = 0
    }
    
    func opacity(_ value: CGFloat) {
        textColor = textColor.withAlphaComponent(value)
    }
    
    func strikethrough(_ isStrikethrough: Bool) {
        guard let attributedText else { return }
        
        let text = attributedText.string
        
        if isStrikethrough {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(
                NSAttributedString.Key.strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSMakeRange(0, attributedString.length)
            )
            self.attributedText = attributedString
        } else {
            self.attributedText = NSMutableAttributedString(string: text)
        }
    }
}
