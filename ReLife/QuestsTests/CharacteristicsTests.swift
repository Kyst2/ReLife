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
        realmController.add(characteristic: Characteristic(name: "Health", icon: "trash"))
        
        let fetchedQuest = realmController.characteristicsAll.first

        XCTAssertNotNil(fetchedQuest)
        XCTAssertEqual(fetchedQuest?.name , "Health")
    }
    
    // Test removing a characteristic
    func testRemoveChars() {
        let quest = Quest(name: "Quest", icon: .moon, color: .gray, charachPoints: [Characteristic(name: "Health", icon: "trash"):15,Characteristic(name: "Strong", icon: "trash"):10], repeatType: .eachWeek(days: [5]))
        realmController.add(quest: quest)
        
        let char = Characteristic(name: "Health", icon: "trash")
        realmController.add(characteristic: char)
        let char2 = Characteristic(name: "Strong", icon: "trash")
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
        let characteristic = Characteristic(name: "char1", icon: "trash")
        
        realmController.add(characteristic: characteristic)
        
        realmController.update(characteristicKey: characteristic.key, withValues: Characteristic(name: "char2", icon: "tray"))
        
        XCTAssertEqual(realmController.characteristicsAll.filter({$0.name == "char2"}).first?.name, "char2")
        XCTAssertEqual(realmController.characteristicsAll.first?.key, "char2")
    }
    func testGetCharsPoints() {
        realmController.add(characteristic: Characteristic(name: "Health", icon: "trash"))
        realmController.add(characteristic: Characteristic(name: "Level", icon: "trash"))
        let helth = realmController.characteristicsAll.filter{ $0.name == "Health"}.first!
        let level = realmController.characteristicsAll.filter{ $0.name == "Level"}.first!
        
        print("2: \(realmController.characteristicsAll[0].key)")
        
        let charSet1 = [ helth: 10, level: 30]
        let charSet2 = [ helth: 15]
        
        let quest = Quest(name: "Quest1", icon: .tray, color: .black, charachPoints: charSet1, repeatType: .eachWeek(days: [4]))
        realmController.add(quest: quest)
        let quest2 = Quest(name: "Quest2", icon: .tray, color: .black, charachPoints: charSet2, repeatType: .eachWeek(days: [4]))
        realmController.add(quest: quest)
        
        realmController.add(history: History(quest: quest))
        realmController.add(history: History(quest: quest))
        
        XCTAssertEqual(realmController.characteristicsAll.count, 2)
        XCTAssertEqual(realmController.questsAll.count, 1)
        
        var allCharacsPoints = realmController.getAllCharacteristicPoints().map{ $0 }
        
        var healthPoints = allCharacsPoints.filter({$0.charac.name == "Health"})
        var levelPoints = allCharacsPoints.filter{$0.charac.name == "Level"}
        
        XCTAssertEqual(healthPoints.first?.points, 10*2 )
        XCTAssertEqual(levelPoints.first?.points, 30*2 )
        
        realmController.add(history: History(quest: quest))
        realmController.add(history: History(quest: quest2))
        
        allCharacsPoints = realmController.getAllCharacteristicPoints().map{ $0 }
        
//        healthPoints = allCharacsPoints.filter{ $0.key.key == "Health" }.first!.value
//        levelPoints = allCharacsPoints.filter{ $0.key.key == "Level" }.first!.value
        
//        XCTAssertEqual(healthPoints, 10*3 + 15)
//        XCTAssertEqual(levelPoints, 30*3 )
    }
    
    func testGetCharacteristicPoints () {
        realmController.add(characteristic: Characteristic(name: "Health", icon: "trash"))
        realmController.add(characteristic: Characteristic(name: "Level", icon: "trash"))
        let helth = realmController.characteristicsAll.filter{ $0.name == "Health"}.first!
        let level = realmController.characteristicsAll.filter{ $0.name == "Level"}.first!
        
        print("2: \(realmController.characteristicsAll[0].key)")
        
        let charSet1 = [ helth: 10, level: 30]
        let charSet2 = [ helth: 15]
        
        let quest = Quest(name: "Quest1", icon: .tray, color: .black, charachPoints: charSet1, repeatType: .eachWeek(days: [4]))
        realmController.add(quest: quest)
        let quest2 = Quest(name: "Quest2", icon: .tray, color: .black, charachPoints: charSet2, repeatType: .eachWeek(days: [4]))
        realmController.add(quest: quest)
        
        realmController.add(history: History(quest: quest))
        realmController.add(history: History(quest: quest))
    }
}
