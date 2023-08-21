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
        
        realmController.remove(questKey: quest.id)
        let doesNotExist = realmController.questsAll.first(where: { $0.name == "quest1"}) == nil
        
        XCTAssertTrue(doesNotExist)
    }
    
    // More test cases can go here for other methods like update and addCharacteristic
    func testUPDQuest() {
        let quest = Quest(name: "quest1", value: 10, completed: false, timeStart: nil)
        realmController.add(quest: quest)
        print(realmController.questsAll.first!.name)
        realmController.update(questKey: quest.id, withValues: Quest(name: "quest2", value: 15, completed: false, timeStart: nil))
        XCTAssertEqual(realmController.questsAll.first?.value, 15)
    }
    
}
