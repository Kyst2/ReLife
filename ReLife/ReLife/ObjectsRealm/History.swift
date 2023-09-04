import Foundation
import RealmSwift

public class History: Object {
    
    @Persisted(primaryKey: true) var key: String = UUID().uuidString
    @Persisted var dateCompleted: Date = Date()
    @Persisted var quest: Quest?
    
    convenience init(quest: Quest) {
        self.init()
        self.dateCompleted = Date.now
        self.quest = quest
    }
}
