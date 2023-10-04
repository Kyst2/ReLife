import XCTest
import RealmSwift
@testable import ReLife

final class QuestsTests: XCTestCase {
    var realmController: RealmController!
    
    override func setUp() {
        super.setUp()
        
        self.realmController = RealmController(test: true)
        
        realmController.add(characteristic: Characteristic(name: "Health"))
        realmController.add(characteristic: Characteristic(name: "Level"))
    }
    
    override func tearDown() {
        try? realmController.realm.write {
            realmController.realm.deleteAll()
        }
        super.tearDown()
    }
    func test__Add() {
        let charach = realmController.characteristicsAll.first!
//        XCTAssertEqual(, )
    }
    func testAddQuest() {
        XCTAssertEqual(realmController.characteristicsAll.count, 2)
        
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
    
    func testRemoveQuest() {
        let charachSet = [Characteristic : Int]()
        let quest = Quest(name: "Quest", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: .dayOfMonth(days: [1,2]))
        realmController.add(quest: quest)
        
        realmController.remove(questKey: quest.key)
        let doesNotExist = realmController.questsAll.first(where: { $0.name == "quest1"}) == nil
        
        XCTAssertTrue(doesNotExist)
    }
    
    func testUPDQuest() {
        let charachSet = [Characteristic : Int]()
        let quest = Quest(name: "Quest", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: .singleDayQuest(date: Date.now))
        realmController.add(quest: quest)

        realmController.update(questKey: realmController.questsAll.first!.key, withValues: Quest(name: "Quest1", icon: .backpack, color: .gray, charachPoints: charachSet, questRepeatStr: .eachWeek(days: [5])))

        XCTAssertEqual(realmController.questsAll.first?.name, "Quest1")
    }
    
    //Move to essentials tests with Date.From ++++
    func test_DateFrom() {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 3000
        components.month = 1
        components.day = 1
        let date3000_1 = calendar.date(from: components)!.adding(hrs: 2)
        
        let day3000_2 = Date.from(str: "3000/01/01")!.adding(hrs: 2)
        
        XCTAssertEqual(date3000_1, day3000_2)
    }
    
    func testGetQuestsToday() {
        let charachSet = [Characteristic : Int]()
        let day3000 = Date.from(str: "3000/01/01")!.adding(hrs: 2)
        let day3001 = Date.from(str: "3001/01/01")!
        
        let repeatTypes = [
            QuestRepeatType.singleDayQuest(date: day3000),                                 // will be
            QuestRepeatType.singleDayQuest(date: day3001),
            
            QuestRepeatType.eachWeek(days: [4]),                                           // will be
            QuestRepeatType.eachWeek(days: [1,2,6]),
            
            QuestRepeatType.dayOfMonth(days: [1]),                                         // will be
            QuestRepeatType.dayOfMonth(days: [2,4,5,6]),
            
            QuestRepeatType.repeatEvery(days: 2, startingFrom: day3000.adding(days: -2)), // will be
            QuestRepeatType.repeatEvery(days: 3, startingFrom: day3000),                   // will be
            QuestRepeatType.repeatEvery(days: 2, startingFrom: day3001),
            QuestRepeatType.repeatEvery(days: 3, startingFrom: day3000.adding(days: -2)),
        ]
        // thurstday
        
        let quests = repeatTypes.enumerated().map {
            Quest(name: "Quest\($0.offset )", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: $0.element)
        }
        
        quests.forEach { realmController.add(quest: $0) }
        let expected = [realmController.questsAll.filter{$0.name == "Quest0"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest2"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest4"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest6"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest7"}.first!
        ]
        
        XCTAssertEqual(realmController.getQuestsToday(dateNow: day3000),expected)
    }
    
    func testGetSingleQuestHalfYear() {
        let day3000 = Date.from(str: "3000/01/01")!.adding(hrs: 2)
        let dates = [
            QuestRepeatType.singleDayQuest(date: day3000),        // will be
            QuestRepeatType.singleDayQuest(date: day3000.adding(days: +365)),
            QuestRepeatType.singleDayQuest(date: day3000.adding(days: -30)),   //will be
            QuestRepeatType.singleDayQuest(date: day3000.adding(days: -200))
        ]
        
        let charachSet = [Characteristic : Int]()
        
        let quests = dates.enumerated().map {
            Quest(name: "Quest\($0.offset )", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: $0.element)
        }
        
        quests.forEach { realmController.add(quest: $0) }
        
        realmController.add(history: History(quest: quests.last! ) )
        
        XCTAssertEqual(realmController.getSingleQuestHalfYear(dateNow: day3000).count, 2)
    }
    
    func testGetActualQuestToday() {
        let charachSet = [Characteristic : Int]()
        let day3000 = Date.from(str: "3000/01/01")!.adding(hrs: 2)
        let repeatTypes = [
            QuestRepeatType.singleDayQuest(date: day3000),  // will be
            QuestRepeatType.singleDayQuest(date: day3000),
            
            QuestRepeatType.eachWeek(days: [4]),                                           // will be
            QuestRepeatType.eachWeek(days: [1,2,4]),
            
            QuestRepeatType.dayOfMonth(days: [1]),                                         // will be
            QuestRepeatType.dayOfMonth(days: [2,4,5,6]),
            
            QuestRepeatType.repeatEvery(days: 2, startingFrom: day3000.adding(days: -2) ), // will be
            QuestRepeatType.repeatEvery(days: 3, startingFrom: day3000),                   // will be
            QuestRepeatType.repeatEvery(days: 2, startingFrom: day3000),
            QuestRepeatType.repeatEvery(days: 3, startingFrom: day3000.adding(days: +2)),
        ]

        let quests = repeatTypes.enumerated().map {
            Quest(name: "Quest\($0.offset )", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: $0.element )
        }
        
        quests.forEach{ realmController.add(quest: $0) }
        
        realmController.add(history: History(quest: quests[1],dateCompleted: day3000))
        realmController.add(history: History(quest: quests[8],dateCompleted: day3000))
        realmController.add(history: History(quest: quests[3],dateCompleted: day3000))
        
        let expected = [
              realmController.questsAll.filter{$0.name == "Quest0"}.first!,
            realmController.questsAll.filter{$0.name == "Quest2"}.first!,
            realmController.questsAll.filter{$0.name == "Quest4"}.first!,
            realmController.questsAll.filter{$0.name == "Quest6"}.first!,
            realmController.questsAll.filter{$0.name == "Quest7"}.first!
        ]
        
        XCTAssertEqual(realmController.getActualQuestsToday(dateNow: day3000).count, 5 )
    }
    func testGetFinishQuestsToday() {
        let day3000 = Date.from(str: "3000/01/01")!.adding(hrs: 2)
        let charachSet = [Characteristic : Int]()
        
        let repeatTypes = [
            QuestRepeatType.singleDayQuest(date: day3000),            // will be
            QuestRepeatType.singleDayQuest(date: day3000),
            
            QuestRepeatType.eachWeek(days: [4]),                                           // will be
            QuestRepeatType.eachWeek(days: [1,2]),
            
            QuestRepeatType.dayOfMonth(days: [1]),                                         // will be
            QuestRepeatType.dayOfMonth(days: [2,4,5,6]),
            
            QuestRepeatType.repeatEvery(days: 2, startingFrom: day3000.adding(days: -2)), // will be
            QuestRepeatType.repeatEvery(days: 3, startingFrom: day3000),                   // will be
            QuestRepeatType.repeatEvery(days: 2, startingFrom: day3000),
            QuestRepeatType.repeatEvery(days: 3, startingFrom: day3000.adding(days: +2)),
        ]
        
        
        let quests = repeatTypes.enumerated().map {
            Quest(name: "Quest\($0.offset )", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: $0.element )
        }
        quests.forEach{ realmController.add(quest: $0) }
        
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest0"}.first!,dateCompleted: day3000))
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest0"}.first!,dateCompleted: day3000))
        realmController.add(history: History(quest: quests[0],dateCompleted: day3000))
        realmController.add(history: History(quest: quests[2],dateCompleted: day3000))
        realmController.add(history: History(quest: quests[4],dateCompleted: day3000))
        realmController.add(history: History(quest: quests[6],dateCompleted: day3000))
        realmController.add(history: History(quest: quests[7],dateCompleted: day3000))
        
        let expected = [
            realmController.questsAll.filter{$0.name == "Quest0"}.first!:3,
            realmController.questsAll.filter{$0.name == "Quest2"}.first!:1,
            realmController.questsAll.filter{$0.name == "Quest4"}.first!:1,
            realmController.questsAll.filter{$0.name == "Quest6"}.first!:1,
            realmController.questsAll.filter{$0.name == "Quest7"}.first!:1
        ]
        XCTAssertEqual(realmController.getFinishedQuestsToday(dateNow: day3000),expected)
    }

    
    
}

