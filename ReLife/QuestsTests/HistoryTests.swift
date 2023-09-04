import XCTest
import RealmSwift
@testable import ReLife

final class HistoryTests: XCTestCase {
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
    
    // Test adding a characteristic
    func testAddHistory() {
        
        var quest = realmController.generateQuest()
        
        let history = History(quest: quest)
        
        realmController.add(history: history)
        let fetchedQuest = realmController.allHistory.first
        
        XCTAssertNotNil(fetchedQuest)
        XCTAssertEqual(fetchedQuest?.quest?.name, "quest")
    }
    
    // Test removing a characteristic
    func testRemoveHistory() {
        var quest = realmController.generateQuest()
        
        let history = History(quest: quest)
        realmController.add(history: history)
        
        realmController.remove(historyKey: realmController.allHistory.first!.key)
        
        let doesNotExist = realmController.allHistory.first?.quest?.name == nil
        
        XCTAssertTrue(doesNotExist)
    }
    
    func test_calcPointsPerCharacteristic() {
        var quest1 = realmController.generateQuest()
        var quest2 = realmController.generateQuest()
        
        realmController.add(history: History(quest: quest1) )
        realmController.add(history: History(quest: quest1) )
        realmController.add(history: History(quest: quest1) )
        
        realmController.add(history: History(quest: quest2) )
        realmController.add(history: History(quest: quest2) )
        
        
        
        
        
    }
    
    
}

fileprivate extension RealmController {
    func generateQuest() -> Quest {
        var charachSet = [Characteristic : Int]()
        charachSet[self.characteristicsAll.first!] = 10
        
        let quest = Quest(name: "quest_\(UUID().uuidString)", icon: .batteryFull, color: .green, charachPoints: charachSet, questRepeatStr: .dayOfMonth(days: [1,2]))
        
        return quest
    }
}
