import Foundation
import RealmSwift

public class History: Object {
    
    @Persisted(primaryKey: true) var key: String = UUID().uuidString
    @Persisted var dateCompleted: Date = Date()
    @Persisted var quest: Quest?
//
//    override init() {
//        self.dateCompleted = Date.now
//        self.quest = nil
//    }
    
    convenience init(dateCompleted: Date, quest: Quest) {
        self.init()
        self.dateCompleted = dateCompleted
        self.quest = quest
    }
}
