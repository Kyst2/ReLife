import XCTest
import RealmSwift
//@testable import ReLife

final class QuestsTests: XCTestCase {
    var realmControl: RealmController = RealmController()
//    var realm: Realm!
//    override func setUp() {
//           super.setUp()
//
//       }
    
    func test_QuestCteate() {
        
        realmControl.add(quest: Quest(key: "1", name: "Test1", value: 10, blablabla: true))
        
        XCTAssertEqual(realmControl.questsAll.filter{ $0.name == "Test1"}.count, 1)
        
        fatalError()
    }
    
    func testDelete () {
//        let data = Quest(key: "1", name: "PochistitbZubIb", value: 13, blablabla: false)
//
//        realmControl.add(quest: data)
//
//        realmControl.remove(questKey: data.key)
        
        XCTAssertEqual(realmControl.questsAll.filter{ $0.name == "Test1"}.count, 0)
    }
//    func testUpdate() {
//        let data = Quest(key: "1", name: "PochistitbZubIb", value: 13, blablabla: false)
//        self.bdc.add(quest: data)
//        self.bdc.update(questKey: "1", withValues: Quest(key: "1", name: "PochistitbZubIb", value: 25, blablabla: true))
//
//        XCTAssertEqual(self.bdc.allQuests.first!.value,25)
//    }
    
}
