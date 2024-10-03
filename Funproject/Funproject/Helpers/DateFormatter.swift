import Foundation

class DateFormatterService {
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    }
    
    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
}
