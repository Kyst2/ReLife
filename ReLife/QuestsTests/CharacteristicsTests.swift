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
        let characteristic = Characteristic(name: "Health123")
        
        realmController.add(characteristic: characteristic)
        realmController.remove(characteristicKey: characteristic.key)
        
        let doesNotExist = realmController.characteristicsAll.first(where: { $0.name == characteristic.name}) == nil
        
        XCTAssertTrue(doesNotExist)
    }
    
    // More test cases can go here for other methods like update and addCharacteristic
    func testUPDCharacteristic() {
        let characteristic = Characteristic(name: "char1")
        
        realmController.add(characteristic: characteristic)
        
        realmController.update(characteristicKey: characteristic.key, withValues: Characteristic(name: "char2"))
        
        XCTAssertEqual(realmController.characteristicsAll.filter({$0.name == "char2"}).first?.name, "char2")
        XCTAssertEqual(realmController.characteristicsAll.filter({$0.key == characteristic.key}).first?.name, "char2")
    }
}
