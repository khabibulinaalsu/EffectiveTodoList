import Foundation

extension String {
    func countString(_ count: Int) -> String {
        let suffix = {
            if (11...20).contains(count % 100) {
                return ""
            } else {
                switch count % 10 {
                case 1:
                    return "а"
                case 2, 3, 4:
                    return "и"
                default:
                    return ""
                }
            }
        }()
        
        return "\(count) \(self)\(suffix)"
    }
}
