import Foundation
import RealmSwift

class Characteristic: Object {
    @Persisted(primaryKey: true) var key: String
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var points: Int
}


class Quest: Object {
    @Persisted(primaryKey: true) var key: String
    @Persisted var name: String
    @Persisted var value: Int
    @Persisted var blablabla: Bool

     init(key: String, name: String, value: Int, blablabla: Bool) {
        self.name = name
        self.value = value
        self.blablabla = blablabla
    }
}
