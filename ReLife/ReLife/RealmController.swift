import Foundation

class RealmController {
    let bd: BD
    
    init() {
        self.bd = BD()
        
    }
    
    var allQuests: [Quest] { bd.quests }
    
    var allCharacteristics: [Characteristic] { bd.characteristics }
    
    func add(quest: Quest) {
        
    }
    
    func remove(questKey: String) {
        
    }
    
    func update(questKey: String, withValues: Quest) {
        
    }
    
    func add(characteristic data: Characteristic) {
//        DispatchQueue.main.async {
            self.bd.characteristics.append(data)
//        }
    }
    
    func remove(characteristicKey: String) {
        
    }
    
    func update(characteristicKey: String, withValues: Characteristic) {
        
    }
    
    
}
