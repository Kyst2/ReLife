import Foundation
import RealmSwift

public class RealmController {
    var realm: Realm
    
    var questsAll: [Quest] { realm.objects(Quest.self).map{ $0 } }
    var characteristicsAll: [Characteristic] { realm.objects(Characteristic.self).map{ $0 } }
    
    public init(test: Bool = false) {
        
        let config = test
        ? Realm.Configuration(fileURL: URL.applicationDirectory.appendingPathComponent("realmTest.realm") ,inMemoryIdentifier: "testRealm")
                        : Realm.Configuration(encryptionKey: nil)
        
        let r = try? Realm(configuration: config)
        
        self.realm = r!
        
    }
    
    func add(quest: Quest) {
        try! realm.write {
            realm.add(quest)
        }
    }
    
    func remove(questKey: String) {
        if let quest = realm.object(ofType: Quest.self, forPrimaryKey: questKey) {
            try! realm.write {
                realm.delete(quest)
            }
        }
    }
    
    func update(questKey: String, withValues: Quest) {
        if let quest = realm.object(ofType: Quest.self, forPrimaryKey: questKey) {
            try! realm.write {
                quest.name = withValues.name
                quest.value = withValues.value
                quest.completed = withValues.completed
            }
        }
    }
    
    func add(characteristic: Characteristic) {
        try! realm.write {
            realm.add(characteristic)
        }
    }
    
    func remove(characteristicKey: String) {
        if let characteristic = realm.object(ofType: Characteristic.self, forPrimaryKey: characteristicKey) {
            try! realm.write {
                realm.delete(characteristic)
            }
        }
    }
    
    func update(characteristicKey: String, withValues: Characteristic) {
        if let characteristic = realm.object(ofType: Characteristic.self, forPrimaryKey: characteristicKey) {
            try! realm.write {
                characteristic.name = withValues.name
                characteristic.points = withValues.points
            }
        }
    }   
}
