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
        var charachSet = [Characteristic : Int]()
        let history = History(dateCompleted: Date.now, quest: Quest(name: "quest", icon: .batteryFull, color: .green, charachPoints: charachSet))

        realmController.add(history: history)
        let fetchedQuest = realmController.allHistory.first

        XCTAssertNotNil(fetchedQuest)
        XCTAssertEqual(fetchedQuest?.quest?.name, "quest")
    }
    
    // Test removing a characteristic
    func testRemoveHistory() {
        var charachSet = [Characteristic : Int]()
        let history = History(dateCompleted: Date.now, quest: Quest(name: "quest", icon: .batteryFull, color: .green, charachPoints: charachSet))
        realmController.add(history: history)
        
        realmController.remove(historyKey: realmController.allHistory.first!.key)

        let doesNotExist = realmController.allHistory.first?.quest?.name == nil

        XCTAssertTrue(doesNotExist)
    }
    
    // More test cases can go here for other methods like update and addCharacteristic
    func testUPDHistory() {
        var charachSet = [Characteristic : Int]()
        let history = History(dateCompleted: Date.now, quest: Quest(name: "quest", icon: .batteryFull, color: .green, charachPoints: charachSet))
        realmController.add(history: history)
        
        print(realmController.allHistory.first?.quest?.name ?? "2")
        realmController.update(historyKey: realmController.allHistory.first!.key, withValues: History(dateCompleted: Date.now, quest: Quest(name: "room", icon: .bicycle, color: .red, charachPoints: charachSet)))
        
        print(realmController.allHistory.first?.quest?.name ?? "1")
        
        XCTAssertEqual(realmController.allHistory.first?.quest?.name, "room")
    }
    
}

