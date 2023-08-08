import Foundation
import RealmSwift

class RealmController {
    let realm: Realm
    
    var questsAll: [Quest] { realm.objects(Quest.self).map{ $0 } }
    
    init() {
        try? FileManager.default.createDirectory(atPath: "/Users/andrewkuzmich/Library/Containers/com.rogaAndKopytaBugaiv.ReLife/Data/Library/!!111/", withIntermediateDirectories: true, attributes: nil)
        
        
        let realmDbUrl = URL(filePath: "/Users/andrewkuzmich/Library/Containers/com.rogaAndKopytaBugaiv.ReLife/Data/Library/!!111/RealmDb.realm")
        
        let config = Realm.Configuration(fileURL: realmDbUrl)
        
        print("ZZ \(config.fileURL!.path )")
        
        do {
            print("ZZ1")
            realm = try Realm(configuration: config )
            
            print("ZZ2")
        } catch let error {
            print("ZZ3")
            print(error.localizedDescription)
            
            fatalError()
        }
        
        print("hello")
        
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
                quest.blablabla = withValues.blablabla
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


public extension URL {
    static var userHome : URL   {
        URL(fileURLWithPath: userHomePath, isDirectory: true)
    }
    
    static var userHomePath : String   {
        let pw = getpwuid(getuid())
        if let home = pw?.pointee.pw_dir {
            return FileManager.default.string(withFileSystemRepresentation: home, length: Int(strlen(home)))
        }
        
        fatalError()
    }
}
