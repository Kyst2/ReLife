import Foundation

class SettingsViewModel: ObservableObject {
    let realmController = RealmController()
    @Published var allQuests: [Quest] = []
    @Published var allCharacteristics: [Characteristic] = []
    
    init() {
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
}
