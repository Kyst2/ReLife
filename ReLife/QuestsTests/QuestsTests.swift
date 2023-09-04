import XCTest
import RealmSwift
@testable import ReLife

final class QuestsTests: XCTestCase {
    var realmController: RealmController!
    
    override func setUp() {
        super.setUp()
        
        self.realmController = RealmController(test: true)
        
        realmController.add(characteristic: Characteristic(name: "Health"))
    }
    
    override func tearDown() {
        try? realmController.realm.write {
            realmController.realm.deleteAll()
        }
        super.tearDown()
    }
    
    // Test adding a quest
    func testAddQuest() {
        XCTAssertEqual(realmController.characteristicsAll.count, 1)
        
        let charach = realmController.characteristicsAll.first!
        
        var charachSet = [Characteristic : Int]()
        charachSet[charach] = 10
        
        let quest = Quest(name: "Quest", icon: .backpack, color: .black, charachPoints: charachSet, questRepeatStr: .eachWeek(days: [1,3,4]) )
        
        realmController.add(quest: quest)
        let fetchedQuest = realmController.questsAll.first
        
        XCTAssertNotNil(fetchedQuest)
        XCTAssertEqual(fetchedQuest?.name, "Quest")
        
        XCTAssertEqual(fetchedQuest!.colorHex[0], 0)
        XCTAssertEqual(fetchedQuest!.colorHex[1], 0)
        XCTAssertEqual(fetchedQuest!.colorHex[2], 0)
        
        XCTAssertEqual(fetchedQuest!.charachPoints[charach.key], 10)
        XCTAssertEqual(fetchedQuest!.questRepeat, .eachWeek(days: [1,3,4]))
        
        
    }
    
    // Test removing a quest
    func testRemoveQuest() {
        
        var charachSet = [Characteristic : Int]()
        
        let quest = Quest(name: "Quest", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: .dayOfMonth(days: [1,2]))
        realmController.add(quest: quest)
        
        realmController.remove(questKey: quest.key)
        let doesNotExist = realmController.questsAll.first(where: { $0.name == "quest1"}) == nil
        
        XCTAssertTrue(doesNotExist)
    }
    
    // More test cases can go here for other methods like update and addCharacteristic
    func testUPDQuest() {
        var charachSet = [Characteristic : Int]()
        let quest = Quest(name: "Quest", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: .singleDayQuest(date: Date.now))
        realmController.add(quest: quest)
        print(realmController.questsAll.first!.name)
        realmController.update(questKey: realmController.questsAll.first!.key, withValues: Quest(name: "VIE", icon: .bathtub, color: .yellow, charachPoints: charachSet, questRepeatStr: .dayOfMonth(days: [1])))
        XCTAssertEqual(realmController.questsAll.first?.name, "VIE")
    }
    
}
