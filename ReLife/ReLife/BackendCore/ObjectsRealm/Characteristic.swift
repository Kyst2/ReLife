import Foundation
import RealmSwift

public class Characteristic: Object, Identifiable {
    @Persisted(primaryKey: true) var key: String
    @Persisted private(set) var name: String
    @Persisted var icon: String
    @Persisted var points: Int
    
    public override static func primaryKey() -> String? {
        return "key"
    }
    
    override init() {
        super.init()
        self.key = UUID().uuidString
        self.name = ""
        self.points = 0
    }
    
    convenience init(key: String, name: String, icon: String) {
        self.init()
        self.name = name
        self.icon = icon
        self.key = key
        self.points = 0
    }
    
    convenience init(name: String, icon: String) {
        self.init()
        self.name = name
        self.icon = icon
        self.key = name.lowercased()
        self.points = 0
    }
    
    func setName(_ name: String) {
        self.key = name
        self.name = name
    }
    
    static func == (lhs: Characteristic, rhs: Characteristic) -> Bool {
        return lhs.key == rhs.key && lhs.icon == rhs.icon
    }
}
