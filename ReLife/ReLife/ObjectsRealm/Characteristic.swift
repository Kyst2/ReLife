import Foundation
import RealmSwift

public class Characteristic: Object {
    @Persisted(primaryKey: true) var key: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var icon: String
    
    public override init(){
        super.init()
        self.name = ""
    }
    
    public init(name: String) {
        super.init()
        self.name = name
        
    }
}
