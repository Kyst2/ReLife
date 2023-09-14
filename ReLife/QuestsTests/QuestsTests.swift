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
        let tmp8 = QuestRepeatType.repeatEvery(days: 3, startingFrom: day3000)                   // will be
        let tmp9 = QuestRepeatType.repeatEvery(days: 2, startingFrom: day3001)
        let tmp10 = QuestRepeatType.repeatEvery(days: 3, startingFrom: day3000.adding(days: -2))
        
        // 1 3 5 7 8
        let charachSet = [Characteristic : Int]()
        
        let quest = Quest(name: "Quest1", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp1)
        realmController.add(quest: quest)
        let quest2 = Quest(name: "Quest2", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp2)
        realmController.add(quest: quest2)

        let quest3 = Quest(name: "Quest3", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp3)
        realmController.add(quest: quest3)
        let quest4 = Quest(name: "Quest4", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp4)
        realmController.add(quest: quest4)

        let quest5 = Quest(name: "Quest5", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp5)
        realmController.add(quest: quest5)
        let quest6 = Quest(name: "Quest6", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp6)
        realmController.add(quest: quest6)
        let quest7 = Quest(name: "Quest7", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp7)
        realmController.add(quest: quest7)
        let quest8 = Quest(name: "Quest8", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp8)
        realmController.add(quest: quest8)
        let quest9 = Quest(name: "Quest9", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp9)
        realmController.add(quest: quest9)
        let quest10 = Quest(name: "Quest10", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp10)
        realmController.add(quest: quest10)
        
        XCTAssertEqual(realmController.getQuestsToday(dateNow: day3000),
                       [realmController.questsAll.filter{$0.name == "Quest1"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest3"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest5"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest7"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest8"}.first!
                       ])
    }
    
    func testGetSingleQuestHalfYear() {
        let day2023 = Date.from(str: "2023/09/12")!.adding(hrs: 3)
        
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
            QuestRepeatType.singleDayQuest(date: (Date.from(str: "2023/09/13")!.adding(days: +1))),  // will be
            QuestRepeatType.singleDayQuest(date: Date.now.adding(hrs: +3)),
            
            QuestRepeatType.eachWeek(days: [4]),                                           // will be
            QuestRepeatType.eachWeek(days: [1,2,6]),
            
            QuestRepeatType.dayOfMonth(days: [13]),                                         // will be
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
        
        let expected = [
//              realmController.questsAll.filter{$0.name == "Quest1"}.first!,
            realmController.questsAll.filter{$0.name == "Quest3"}.first!,
            realmController.questsAll.filter{$0.name == "Quest5"}.first!,
            realmController.questsAll.filter{$0.name == "Quest7"}.first!,
            realmController.questsAll.filter{$0.name == "Quest8"}.first!
        ]
        
        XCTAssertEqual(realmController.getActualQuestsToday(), expected )
    }
    
    
    
    func testGetFinishQuestsToday() {
        let tmp1 = QuestRepeatType.singleDayQuest(date: (Date.from(str: "2023/09/13")!.adding(hrs: +3)))            // will be
        let tmp2 = QuestRepeatType.singleDayQuest(date: Date.now.adding(hrs: +3))
        
        let tmp3 = QuestRepeatType.eachWeek(days: [4])                                           // will be
        let tmp4 = QuestRepeatType.eachWeek(days: [1,2,6])
        
        let tmp5 = QuestRepeatType.dayOfMonth(days: [13])                                         // will be
        let tmp6 = QuestRepeatType.dayOfMonth(days: [2,4,5,6,13])
        
        let tmp7 = QuestRepeatType.repeatEvery(days: 2, startingFrom: Date.now.adding(days: -2) ) // will be
        let tmp8 = QuestRepeatType.repeatEvery(days: 3, startingFrom: Date.now)                   // will be
        let tmp9 = QuestRepeatType.repeatEvery(days: 2, startingFrom: Date.now)
        let tmp10 = QuestRepeatType.repeatEvery(days: 3, startingFrom: Date.now.adding(days: +2))
        //1 3 5 7 8
        let charachSet = [Characteristic : Int]()
        let quest = Quest(name: "Quest1", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp1)
        realmController.add(quest: quest)
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest1"}.first!))
        print(Date.from(str: "2023/09/13")!.adding(hrs: 22))
        let quest2 = Quest(name: "Quest2", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp2)
        realmController.add(quest: quest2)
        

        let quest3 = Quest(name: "Quest3", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp3)
        realmController.add(quest: quest3)
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest3"}.first!))
        let quest4 = Quest(name: "Quest4", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp4)
        realmController.add(quest: quest4)

        let quest5 = Quest(name: "Quest5", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp5)
        realmController.add(quest: quest5)
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest5"}.first!))
        let quest6 = Quest(name: "Quest6", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp6)
        realmController.add(quest: quest6)
        let quest7 = Quest(name: "Quest7", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp7)
        realmController.add(quest: quest7)
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest7"}.first!))
        let quest8 = Quest(name: "Quest8", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp8)
        realmController.add(quest: quest8)
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest8"}.first!))
        let quest9 = Quest(name: "Quest9", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp9)
        realmController.add(quest: quest9)
        
        
        let quest10 = Quest(name: "Quest10", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: tmp10)
        realmController.add(quest: quest10)
        
        XCTAssertEqual(realmController.getFinishedQuestsToday(),
                       [
//                        realmController.questsAll.filter{$0.name == "Quest1"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest3"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest5"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest7"}.first!,
                        realmController.questsAll.filter{$0.name == "Quest8"}.first!
                       ])
    }
    
    func testGetCharsPoints() {
        let charSet1 = [ Characteristic(name: "Health"): 10]
        let charSet2 = [ Characteristic(name: "Health"): 15]
        let charSet3 = [ Characteristic(name: "Health"): 25]
        let charSet4 = [ Characteristic(name: "LEvel"): 30]
        
        let quest = Quest(name: "Quest1", icon: .americanFootball, color: .black, charachPoints: charSet1, questRepeatStr: .eachWeek(days: [4]))
        realmController.add(quest: quest)
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest1"}.first!))
        let quest2 = Quest(name: "Quest2", icon: .americanFootball, color: .black, charachPoints: charSet2, questRepeatStr: .eachWeek(days: [4]))
        realmController.add(quest: quest2)
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest2"}.first!))
        let quest3 = Quest(name: "Quest3", icon: .americanFootball, color: .black, charachPoints: charSet3, questRepeatStr: .eachWeek(days: [4]))
        realmController.add(quest: quest3)
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest3"}.first!))
        let quest4 = Quest(name: "Quest4", icon: .americanFootball, color: .black, charachPoints: charSet4, questRepeatStr: .eachWeek(days: [4]))
        realmController.add(quest: quest4)
        realmController.add(history: History(quest: realmController.questsAll.filter{$0.name == "Quest4"}.first!))
        
        XCTAssertEqual(realmController.getCharacteristicPoints(characteristic: "Health"),50)
    }
}

