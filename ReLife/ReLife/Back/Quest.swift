import Foundation
import RealmSwift

public class Quest: Object {
    @Persisted(primaryKey: true) var key: String
    @Persisted var name: String
    @Persisted var value: Int
    @Persisted var completed: Bool
    @Persisted var timeStart: Date?
    
    public override init() {
        super.init()
        
        self.key = UUID().uuidString
        self.name = ""
        self.value = 0
        self.completed = false
        self.timeStart = nil
    }
    
    
    public init(name: String, value: Int, completed: Bool , timeStart: Date?) {
        super.init()
        self.name = name
        self.value = value
        self.completed = completed
        self.timeStart = timeStart
    }
}
