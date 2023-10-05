import XCTest
import RealmSwift
@testable import ReLife

final class CharacteristicsTests: XCTestCase {
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
    
    // Test adding a characteristic
    func testAddCharacteristic() {
        realmController.add(characteristic: Characteristic(name: "Health"))
        
        let fetchedQuest = realmController.characteristicsAll.first

        XCTAssertNotNil(fetchedQuest)
        XCTAssertEqual(fetchedQuest?.name , "Health")
    }
    
    // Test removing a characteristic
    func testRemoveChars() {
        let quest = Quest(name: "Quest", icon: .moon, color: .gray, charachPoints: [Characteristic(name: "Health"):15,Characteristic(name: "Strong"):10], questRepeatStr: .eachWeek(days: [5]))
        realmController.add(quest: quest)
        
        let char = Characteristic(name: "Health")
        realmController.add(characteristic: char)
        let char2 = Characteristic(name: "Strong")
        realmController.add(characteristic: char2)
        print(realmController.questsAll.first?.charachPoints)
        
        realmController.remove(characteristicKey: realmController.characteristicsAll.first!.key)
        print(realmController.questsAll.first?.charachPoints)
        
        XCTAssertTrue(realmController.characteristicsAll.count == 1)
        XCTAssertEqual(realmController.questsAll.first?.charachPoints.count, 1 )
        print(realmController.questsAll.first!)
    }
    
    // More test cases can go here for other methods like update and addCharacteristic
    func testUPDCharacteristic() {
        let characteristic = Characteristic(name: "char1")
        
        realmController.add(characteristic: characteristic)
        
        realmController.update(characteristicKey: characteristic.key, withValues: Characteristic(name: "char2"))
        
        XCTAssertEqual(realmController.characteristicsAll.filter({$0.name == "char2"}).first?.name, "char2")
        XCTAssertEqual(realmController.characteristicsAll.first?.key, "char2")
    }
    func testGetCharsPoints() {
        realmController.add(characteristic: Characteristic(name: "Health"))
        realmController.add(characteristic: Characteristic(name: "Level"))
        let helth = realmController.characteristicsAll.filter{ $0.name == "Health"}.first!
        let level = realmController.characteristicsAll.filter{ $0.name == "Level"}.first!
        
        print("2: \(realmController.characteristicsAll[0].key)")
        
        let charSet1 = [ helth: 10, level: 30]
        let charSet2 = [ helth: 15]
        
        let quest = Quest(name: "Quest1", icon: .americanFootball, color: .black, charachPoints: charSet1, questRepeatStr: .eachWeek(days: [4]))
        realmController.add(quest: quest)
        let quest2 = Quest(name: "Quest2", icon: .americanFootball, color: .black, charachPoints: charSet2, questRepeatStr: .eachWeek(days: [4]))
        realmController.add(quest: quest)
        
        realmController.add(history: History(quest: quest))
        realmController.add(history: History(quest: quest))
        
        XCTAssertEqual(realmController.characteristicsAll.count, 2)
        XCTAssertEqual(realmController.questsAll.count, 1)
        
        var allCharacsPoints = realmController.getAllCharacteristicPoints().map{ $0 }
        
        var healthPoints = allCharacsPoints.filter{ $0.key.key == "Health" }.first!.value
        var levelPoints = allCharacsPoints.filter{ $0.key.key == "Level" }.first!.value
        
        XCTAssertEqual(healthPoints, 10*2 )
        XCTAssertEqual(levelPoints, 30*2 )
        
        realmController.add(history: History(quest: quest))
        realmController.add(history: History(quest: quest2))
        
        allCharacsPoints = realmController.getAllCharacteristicPoints().map{ $0 }
        
        healthPoints = allCharacsPoints.filter{ $0.key.key == "Health" }.first!.value
        levelPoints = allCharacsPoints.filter{ $0.key.key == "Level" }.first!.value
        
        XCTAssertEqual(healthPoints, 10*3 + 15)
        XCTAssertEqual(levelPoints, 30*3 )
    }
}
