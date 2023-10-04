import Foundation
import RealmSwift

public class History: Object {
    
    @Persisted(primaryKey: true) var key: String = UUID().uuidString
    @Persisted var dateCompleted: Date
    @Persisted var quest: Quest?
    
    convenience init(quest: Quest , dateCompleted: Date = Date.now) {
        self.init()
        self.dateCompleted = dateCompleted.dateWithoutTime()
        self.quest = quest
    }
}
