import Foundation
import RealmSwift

public class History: Object {
    
    @Persisted var dateCompleted: Date = Date()
    @Persisted var quest: Quest?
    
    public override init() {
        super.init()
        self.dateCompleted = dateCompleted
        self.quest = quest
    }
}
