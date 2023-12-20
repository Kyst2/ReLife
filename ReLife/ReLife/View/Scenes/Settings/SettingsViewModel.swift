import Foundation

class SettingsViewModel: ObservableObject {
    static let shared = SettingsViewModel()
    
    let realmController = RealmController.shared
    @Published var tab: SettingsTab = .general
    @Published var allQuests: [Quest] = []
    @Published var allCharacteristics: [Characteristic] = []
    
    private init() {
        refresh()
    }
    
    func refresh() {
        let newAllQuests = realmController.questsAll.sorted{$0.name < $1.name}
        let newAllCharacteristics = realmController.characteristicsAll
        if self.allQuests != newAllQuests {
            self.allQuests = newAllQuests
        }
        if self.allCharacteristics != newAllCharacteristics {
            self.allCharacteristics = newAllCharacteristics
        }
    }
    func addQuest(quest:Quest) {
        realmController.add(quest: quest)
        refresh()
    }
    func deleteQuest(quest:Quest){
        realmController.remove(questKey: quest.key)
        refresh()
    }
    func updQuest(questKey:String , quest:Quest ){
        realmController.update(questKey: questKey, withValues: quest)
        refresh()
    }
}


enum SettingsTab: String {
    case general
    case quests
    case characteristics
}
