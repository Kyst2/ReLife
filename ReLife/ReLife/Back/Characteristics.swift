import Foundation
import RealmSwift

public class Characteristic: Object {
    @Persisted(primaryKey: true) var key: String
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var points: Int
    
    public override init(){
        super.init()
        self.id = UUID().uuidString
        self.name = ""
        self.points = 10
    }
    
    public init(id: String, name: String, points: Int) {
        super.init()
        self.id = id
        self.name = name
        self.points = points
    }
}
