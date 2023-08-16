import XCTest
import RealmSwift
@testable import ReLife

final class QuestsTests: XCTestCase {
    var realmController: RealmController!
    
    override func setUp() {
        super.setUp()
        
        self.realmController = RealmController(test: true)
        
    }
    
    override func tearDown() {
        try? realmController.realm.write {
            realmController.realm.deleteAll()
        }
        super.tearDown()
    }
    
    // Test adding a quest
    func testAddQuest() {
        let quest = Quest(name: "Test Quest", value: 10, completed: false, timeStart: nil)
        
        realmController.add(quest: quest)
        let fetchedQuest = realmController.questsAll.first
        
        XCTAssertNotNil(fetchedQuest)
        XCTAssertEqual(fetchedQuest?.name, "Test Quest")
    }
    
    // Test removing a quest
    func testRemoveQuest() {
        let quest = Quest(name: "quest1", value: 10, completed: false, timeStart: nil)
        realmController.add(quest: quest)
        
        //            realmController.remove(questKey: Quest.primaryKey)
//        let fetchedQuest = realm.objects(Quest.self).first
        
//        XCTAssertNil(fetchedQuest)
    }
    
    // More test cases can go here for other methods like update and addCharacteristic
    
}
