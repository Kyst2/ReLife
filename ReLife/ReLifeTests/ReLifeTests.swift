
import XCTest
import RealmSwift

@testable import ReLife

final class ReLifeTestsCharacteristics: XCTestCase {
    let bdc = RealmController()
    
    func testCreate() {
        DispatchQueue.global(qos: .background).async {
            var data = Characteristic(name: "Attractiveness", points: 10)
            
            bdc.add(characteristic: data)
            
            XCTAssertTrue(bdc.allQuests.filter{ $0.id == data.id }.count == 1)
        }
    }
    
    func testDelete() {
//        var data = Characteristic(name: "Attractiveness", points: 10)
//        self.bd.characteristics.append(data)
//
//        DispatchQueue.global(qos: .background).async {
////            let a = self.bd.characteristics.filter{$0.id  == data.id }.first!
//
//            self.bd.characteristics.remove(at: 0)
//
//            XCTAssertEqual(self.bd.characteristics.first!.name, "Attractiveness")
//        }
    }
    
    func testUpdate() {
    }
}
