import Foundation

/// move to essentials and cover tests
public extension Date {
    static func from(str: String, format: String = "yyyy'/'MM'/'dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: str)
    }
    
    func dayNumOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func dayNumOfMonth() -> Int? {
        return Calendar.current.component(.day, from: self)
    }
    
    func adding(days: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(days*60*60*24))
    }
    
    func adding(hrs: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(hrs*60*60))
    }
    
    func adding(mins: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(mins*60))
    }
    
    func adding(sec: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(sec))
    }
    
    func distance(to: Date, type: Calendar.Component ) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([type], from: self, to: to)
        
        switch type {
        case .day:
            return components.day ?? 0
        case .month:
            return components.month ?? 0
        case .year:
            return components.year ?? 0
        default:
            return 0
        }
        
    }
}
