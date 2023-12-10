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
        let quest = realmController.generateQuest()
        
        realmController.add(quest: quest)
        print(quest)
        
        realmController.add(history: History(quest: quest))
        realmController.add(history: History(quest: quest))
        
        let fetchedQuest = realmController.allHistory.first?.quest != nil
        XCTAssertTrue(fetchedQuest)
        
        XCTAssertTrue(realmController.allHistory.count == 2)
    }
    
    // Test removing a characteristic
    func testRemoveHistory() {
        let quest = realmController.generateQuest()
        
        let history = History(quest: quest)
        realmController.add(history: history)
        
        realmController.remove(historyKey: realmController.allHistory.first!.key)
        
        let doesNotExist = realmController.allHistory.first?.quest?.name == nil
        
        XCTAssertTrue(doesNotExist)
    }
    func testQuestCount() {
        let quest = realmController.generateQuest()
        realmController.add(quest: quest)
        realmController.add(history: History(quest: quest))
        realmController.add(history: History(quest: quest))
//        let count = realmController.getFinishCountQuest(quest: quest)
        XCTAssertTrue(realmController.getFinishCountQuest(quest: quest) == 2)
    }
    func testquestToday() {
        var charachSet = [Characteristic : Int]()
        
        
        let quest = Quest(name: "quest_\(UUID().uuidString)", icon: .batteryFull, color: .green, charachPoints: charachSet, questRepeatStr: .eachWeek(days: [1,2,3,4,5,6,7]),repeatTimes: 5)
        realmController.add(quest: quest)
        let a = Quest(name: "quest_\(UUID().uuidString)", icon: .batteryFull, color: .green, charachPoints: charachSet, questRepeatStr: .eachWeek(days: [1,2,3,4,5,6,7]),repeatTimes: 5)
        realmController.add(quest: a)
        let b = Quest(name: "quest_\(UUID().uuidString)", icon: .batteryFull, color: .green, charachPoints: charachSet, questRepeatStr: .eachWeek(days: [1,2,3,4,5,6,7]),repeatTimes: 5)
        realmController.add(quest: b)
        let c = Quest(name: "quest_\(UUID().uuidString)", icon: .batteryFull, color: .green, charachPoints: charachSet, questRepeatStr: .eachWeek(days: [1,2,3,4,5,6,7]),repeatTimes: 5)
        realmController.add(quest: c)
        
        XCTAssertEqual(realmController.questsAll.count , realmController.getActualQuestsToday().count)
//        print("\(a)")
        
        realmController.add(history: History(quest: quest))
        realmController.add(history: History(quest: quest))
        let history = realmController.allHistory.count
        XCTAssertEqual(history, 2)
        XCTAssertEqual(realmController.questsAll.count, realmController.getQuestsToday()?.count)
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
