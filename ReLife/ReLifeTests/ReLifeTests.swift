//import XCTest
//import RealmSwift
//@testable import ReLife
////
//final class ReLifeTests: XCTestCase {
//    var realm: Realm!
//    var realmController: RealmController!
//    
//    override func setUp() {
//        super.setUp()
//        let config = Realm.Configuration(inMemoryIdentifier: "testRealm")
//        realm = try! Realm(configuration: config)
//        realmController = RealmController()
//        realmController.realm = realm
//    }
//    
//    override func tearDown() {
//        try? realm?.write {
//            realm.deleteAll()
//        }
//        super.tearDown()
//    }
//    
//    // Test adding a quest
//    func testAddQuest() {
//        let quest = Quest()
//        quest.name = "Test Quest"
//        
//        realmController.add(quest: quest)
//        let fetchedQuest = realm.objects(Quest.self).first
//        
//        XCTAssertNotNil(fetchedQuest)
//        XCTAssertEqual(fetchedQuest?.name, "Test Quest")
//    }
//    
//    // Test removing a quest
//    func testRemoveQuest() {
//        let quest = Quest(key: "1", name: "quest1", value: 10, completed: false, timeStart: nil)
//        realmController.add(quest: quest)
//        
//        //            realmController.remove(questKey: Quest.primaryKey)
//        let fetchedQuest = realm.objects(Quest.self).first
//        
//        XCTAssertNil(fetchedQuest)
//    }
//    
//    // More test cases can go here for other methods like update and addCharacteristic
//    
//}
