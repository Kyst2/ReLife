import Foundation
import MoreSwiftUI

class SettingsViewModel: ObservableObject {
    static let shared = SettingsViewModel()
    
    let realmController = RealmController.shared
    @Published var tab: SettingsTab = .general
    @Published var allQuests: [Quest] = []
    @Published var allCharacteristics: [Characteristic] = []
    
    @Published(key: "firstWeekDay") var firstWeeckDay: FirstWeekDay = .monday
    @Published(key: "currLang") var currLang: Language = .system
    @Published(key: "sound") var sound = false
    
    private init() {
        refresh()
        
        forceCurrentLocale = currLang.asLocaleName()
        
        MyApp.signals.subscribeFor( RLSignal.LanguageChaned.self )
            .onUpdate { _ in self.objectWillChange.send() }
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
    case general = "key.settings.tab.general"
    case quests = "key.quests"
    case characteristics = "key.characteristics"
}
