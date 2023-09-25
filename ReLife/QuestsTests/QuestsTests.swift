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
        realmController.update(questKey: realmController.questsAll.first!.name, withValues: Quest(name: "VIE", icon: .bathtub, color: .yellow, charachPoints: charachSet, questRepeatStr: .dayOfMonth(days: [1])))
        XCTAssertEqual(realmController.questsAll.first?.name, "VIE")
    }
    
    //Move to essentials tests with Date.From
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
        let day2023 = Date.from(str: "2023/09/20")!.adding(hrs: 3)
        
        let dates = [
            QuestRepeatType.singleDayQuest(date: day2023),        // will be
            QuestRepeatType.singleDayQuest(date: day2023.adding(days: +365)),
            QuestRepeatType.singleDayQuest(date: day2023.adding(days: -30)),   //will be
            QuestRepeatType.singleDayQuest(date: day2023.adding(days: -200))
        ]
        
        let charachSet = [Characteristic : Int]()
        
        let quests = dates.enumerated().map {
            Quest(name: "Quest\($0.offset )", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: $0.element)
        }
        
        quests.forEach { realmController.add(quest: $0) }
        
        realmController.add(history: History(quest: quests.last! ) )
        
        XCTAssertEqual(realmController.getSingleQuestHalfYear().count, 2)
    }
    
    func testGetActualQuestToday() {
        let charachSet = [Characteristic : Int]()
        
        let repeatTypes = [
            QuestRepeatType.singleDayQuest(date: (Date.from(str: "2023/09/20")!.adding(hrs: +3))),  // will be
            QuestRepeatType.singleDayQuest(date: Date.now.adding(hrs: +3)),
            
            QuestRepeatType.eachWeek(days: [4]),                                           // will be
            QuestRepeatType.eachWeek(days: [1,2,4]),
            
            QuestRepeatType.dayOfMonth(days: [20]),                                         // will be
            QuestRepeatType.dayOfMonth(days: [2,4,5,6]),
            
            QuestRepeatType.repeatEvery(days: 2, startingFrom: Date.now.adding(days: -2) ), // will be
            QuestRepeatType.repeatEvery(days: 3, startingFrom: Date.now),                   // will be
            QuestRepeatType.repeatEvery(days: 2, startingFrom: Date.now),
            QuestRepeatType.repeatEvery(days: 3, startingFrom: Date.now.adding(days: +2)),
        ]
        
        let quests = repeatTypes.enumerated().map {
            Quest(name: "Quest\($0.offset )", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: $0.element )
        }
        
        quests.forEach{ realmController.add(quest: $0) }
        
        realmController.add(history: History(quest: quests[1]))
        realmController.add(history: History(quest: quests[8]))
        realmController.add(history: History(quest: quests[3]))
        
        let expected = [
              realmController.questsAll.filter{$0.name == "Quest0"}.first!,
            realmController.questsAll.filter{$0.name == "Quest2"}.first!,
            realmController.questsAll.filter{$0.name == "Quest4"}.first!,
            realmController.questsAll.filter{$0.name == "Quest6"}.first!,
            realmController.questsAll.filter{$0.name == "Quest7"}.first!
        ]
        
        XCTAssertEqual(realmController.getActualQuestsToday(), expected )
    }
    func testGetFinishQuestsToday() {
        let charachSet = [Characteristic : Int]()
        
        let repeatTypes = [
            QuestRepeatType.singleDayQuest(date: (Date.from(str: "2023/09/25")!.adding(hrs: +3))),            // will be
            QuestRepeatType.singleDayQuest(date: Date.now.adding(hrs: +3)),
            
            QuestRepeatType.eachWeek(days: [7]),                                           // will be
            QuestRepeatType.eachWeek(days: [1,2]),
            
            QuestRepeatType.dayOfMonth(days: [23]),                                         // will be
            QuestRepeatType.dayOfMonth(days: [2,4,5,6]),
            
            QuestRepeatType.repeatEvery(days: 2, startingFrom: Date.now.adding(days: -2)), // will be
            QuestRepeatType.repeatEvery(days: 3, startingFrom: Date.now),                   // will be
            QuestRepeatType.repeatEvery(days: 2, startingFrom: Date.now),
            QuestRepeatType.repeatEvery(days: 3, startingFrom: Date.now.adding(days: +2)),
        ]
        
        
        let quests = repeatTypes.enumerated().map {
            Quest(name: "Quest\($0.offset )", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: $0.element )
        }
        quests.forEach{ realmController.add(quest: $0) }
        
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest0"}.first!))
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest0"}.first!))
        realmController.add(history: History(quest: quests[0]))
        realmController.add(history: History(quest: quests[2]))
        realmController.add(history: History(quest: quests[4]))
        realmController.add(history: History(quest: quests[6]))
        realmController.add(history: History(quest: quests[7]))
        
        
        let expected = [
            realmController.questsAll.filter{$0.name == "Quest0"}.first!:3,
            realmController.questsAll.filter{$0.name == "Quest2"}.first!:1,
            realmController.questsAll.filter{$0.name == "Quest4"}.first!:1,
            realmController.questsAll.filter{$0.name == "Quest6"}.first!:1,
            realmController.questsAll.filter{$0.name == "Quest7"}.first!:1
        ]
        XCTAssertEqual(realmController.getFinishedQuestsToday(),expected)
    }

    func testGetCharsPoints() {
        let helth = realmController.characteristicsAll.filter{ $0.name == "Health"}.first!
        let level = realmController.characteristicsAll.filter{ $0.name == "Level"}.first!
        
        print("1: \(helth.key)")
        
//        realmController.add(characteristic: helth)
//        realmController.add(characteristic: level)
        
        print("2: \(realmController.characteristicsAll[0].key)")
        
        let charSet1 = [ helth: 10, level: 30]
//        let charSet2 = [ helth: 15]
//        let charSet3 = [ helth: 25]
//        let charSet4 = [ level: 30]
//
        let quest = Quest(name: "Quest1", icon: .americanFootball, color: .black, charachPoints: charSet1, questRepeatStr: .eachWeek(days: [4]))
        realmController.add(quest: quest)
//        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest1"}.first!))
//        let quest2 = Quest(name: "Quest2", icon: .americanFootball, color: .black, charachPoints: charSet2, questRepeatStr: .eachWeek(days: [4]))
//        realmController.add(quest: quest2)
//        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest2"}.first!))
//        let quest3 = Quest(name: "Quest3", icon: .americanFootball, color: .black, charachPoints: charSet3, questRepeatStr: .eachWeek(days: [4]))
//        realmController.add(quest: quest3)
//        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest3"}.first!))
//        let quest4 = Quest(name: "Quest4", icon: .americanFootball, color: .black, charachPoints: charSet4, questRepeatStr: .eachWeek(days: [4]))
//        realmController.add(quest: quest4)
//        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest4"}.first!))
        
        realmController.add(history: History(quest: quest))
        realmController.add(history: History(quest: quest))
        
        XCTAssertEqual(realmController.characteristicsAll.count, 2)
        XCTAssertEqual(realmController.questsAll.count, 1)
        
        let allCharacsPoints = realmController.getAllCharacteristicPoints()
        
        XCTAssertEqual(allCharacsPoints[0].allPoints, 10*2 )
        XCTAssertEqual(allCharacsPoints[1].allPoints, 30*2 )
        
        
        
        
        
    }
}

