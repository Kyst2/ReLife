import Foundation
import RealmSwift

public class Characteristic: Object {
    @Persisted(primaryKey: true) var key: String
//    @Persisted private(set) var name: String
    @Persisted var name: String
    @Persisted var icon: String
    
    public override init(){
        super.init()
        self.key = UUID().uuidString
        self.name = ""
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
        self.key = name
    }
    
    func setName(_ name: String) {
        self.key = name
        self.name = name
    }
    
    static func ==(lhs: Characteristic, rhs: Characteristic) -> Bool {
        return lhs.key == rhs.key && lhs.icon == rhs.icon
    }
}
