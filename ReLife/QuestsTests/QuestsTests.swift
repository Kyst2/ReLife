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
    
    func testGetQuestsToday() {
        // first day of hear
        // thurstday
        let day3000 = Date.from(str: "3000/01/01")!.adding(hrs: 2)
        let day3001 = Date.from(str: "3001/01/01")!
        
        let tmp1 = QuestRepeatType.singleDayQuest(date: day3000)                                 // will be
        let tmp2 = QuestRepeatType.singleDayQuest(date: day3001)
        
        let tmp3 = QuestRepeatType.eachWeek(days: [4])                                           // will be
        let tmp4 = QuestRepeatType.eachWeek(days: [1,2,6])
        
        let tmp5 = QuestRepeatType.dayOfMonth(days: [1])                                         // will be
        let tmp6 = QuestRepeatType.dayOfMonth(days: [2,4,5,6])
        
        let tmp7 = QuestRepeatType.repeatEvery(days: 2, startingFrom: day3000.adding(days: -2) ) // will be
        let tmp8 = QuestRepeatType.repeatEvery(days: 1, startingFrom: day3000)                   // will be
        let tmp9 = QuestRepeatType.repeatEvery(days: 2, startingFrom: day3001)
        let tmp10 = QuestRepeatType.repeatEvery(days: 3, startingFrom: day3000.adding(days: -2))
        
        
        
        var charachSet = [Characteristic : Int]()
        let quest = Quest(name: "Quest1", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp1)
        realmController.add(quest: quest)
        let quest2 = Quest(name: "Quest2", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp2)
        realmController.add(quest: quest2)
        let quest3 = Quest(name: "Quest3", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: .repeatEvery(days: 5, startingFrom: Date.distantFuture))
        realmController.add(quest: quest3)
        
        XCTAssertEqual(realmController.getQuestsToday(),
                       [Quest(name: "Quest1", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp1),
                                                         
                        Quest(name: "Quest2", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp2)])
        
    }
    
}

extension Date {
    static func from(str: String, format: String = "yyyy'/'MM'/'dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: str)
    }
    
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func adding(days: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(days*60*60*24))
    }
    
    func adding(hrs: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(hrs*60*60))
    }
    
    func adding(mins: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(mins*60))
    }
    
    func adding(sec: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(sec))
    }
}
