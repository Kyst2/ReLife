import Foundation
import RealmSwift

struct Characteristic {
    var id: String = UUID().uuidString
    var name: String
    var points: Int
}



class BD {
    //Tables
    var characteristics: [Characteristic] = []
    var quests: [Quest] = []
}

struct Quest {
    let key: Int
    let name: String
    let value: Int
    let blablabla: Bool
}

