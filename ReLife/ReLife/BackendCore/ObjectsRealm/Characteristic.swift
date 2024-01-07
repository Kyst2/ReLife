import Foundation
import RealmSwift

public class Characteristic: Object, Identifiable {
    @Persisted(primaryKey: true) var key: String
    @Persisted private(set) var name: String
    @Persisted private var iconStr: String
    @Persisted var points: Int
    
    var icon: CharachIcon { get { CharachIcon(rawValue: self.iconStr) ?? CharachIcon.arrows  } set { self.iconStr = newValue.rawValue } }
    
    public override static func primaryKey() -> String? {
        return "key"
    }
    
    override init() {
        super.init()
        self.key = UUID().uuidString
        self.name = ""
        self.points = 0
    }
    
    convenience init(key: String, name: String, icon: CharachIcon) {
        self.init()
        self.name = name
        self.iconStr = icon.rawValue
        self.key = key
        self.points = 0
    }
    
    convenience init(name: String, icon: CharachIcon) {
        self.init()
        self.name = name
        self.iconStr = icon.rawValue
        self.key = name.lowercased()
        self.points = 0
    }
    
    func setName(_ name: String) {
        self.key = name
        self.name = name
    }
    
    static func == (lhs: Characteristic, rhs: Characteristic) -> Bool {
        return lhs.key == rhs.key && lhs.iconStr == rhs.iconStr
    }
}
