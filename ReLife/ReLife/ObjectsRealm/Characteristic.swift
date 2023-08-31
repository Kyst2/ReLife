import Foundation
import RealmSwift

public class Characteristic: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String
    
    public override init(){
        super.init()
        self.name = ""
    }
    
    public init(name: String) {
        super.init()
        self.name = name
    }
}
