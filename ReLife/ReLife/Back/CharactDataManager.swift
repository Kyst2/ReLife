import Foundation
import RealmSwift

//class CharacteristicDataManager {
//
//    let realm = try! Realm()
//
//    func createCharacteristic(health: Double, attractiveness: Double, mind: Double) {
//        let characteristic = Characteristic(health: health, attractiveness: attractiveness, mind: mind)
//        try! realm.write {
//            realm.add(characteristic)
//        }
//    }
//
//    func readCharacteristic(characteristicID: ObjectId) -> Characteristic? {
//        return realm.object(ofType: Characteristic.self, forPrimaryKey: characteristicID)
//    }
//
//    func updateCharacteristic(characteristicID: ObjectId, health: Double, attractiveness: Double, mind: Double) {
//        if let characteristic = realm.object(ofType: Characteristic.self, forPrimaryKey: characteristicID) {
//            try! realm.write {
//                characteristic.health = health
//                characteristic.attractiveness = attractiveness
//                characteristic.mind = mind
//            }
//        }
//    }
//
//    func deleteCharacteristic(characteristicID: ObjectId) {
//        if let characteristic = realm.object(ofType: Characteristic.self, forPrimaryKey: characteristicID) {
//            try! realm.write {
//                realm.delete(characteristic)
//            }
//        }
//    }
//}
