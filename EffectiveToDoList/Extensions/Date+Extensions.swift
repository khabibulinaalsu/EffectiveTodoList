import Foundation

extension Date {
    var slashStyle: String {
        DateFormatter.slashStyle.string(from: self)
    }
}

extension DateFormatter {
    static let slashStyle: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yy"
        return df
    }()
}
