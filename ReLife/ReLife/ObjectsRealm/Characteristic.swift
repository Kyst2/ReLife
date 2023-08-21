import Foundation
import RealmSwift

public class Characteristic: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var points: Int
    
    public override init(){
        super.init()
        self.name = ""
        self.points = 10
    }
    
    public init(name: String, points: Int) {
        super.init()
        self.name = name
        self.points = points
    }
}
