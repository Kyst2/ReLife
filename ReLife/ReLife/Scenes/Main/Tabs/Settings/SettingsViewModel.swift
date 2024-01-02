import Foundation
import MoreSwiftUI
import AppCoreLight

class SettingsViewModel: NinjaContext.Main , ObservableObject {
    static let shared = SettingsViewModel()
    
    let realmController = RealmController.shared
    @Published var tab: SettingsTab = .general
    @Published var allQuests: [Quest] = []
    @Published var allCharacteristics: [Characteristic] = []
    
    @Published(key: "currLang") var currLang: Language = .system
    
    @Published var allHistoryCount: Int = 0
    
    private override init() {
        super.init()
        
        refresh()
        
        forceCurrentLocale = currLang.asLocaleName()
        
        AppCore.signals.subscribeFor( RLSignal.LanguageChaned.self )
            .onUpdate { _ in self.objectWillChange.send() }
        
        $tab.asyncNinja
            .onUpdate { _ in
                AudioPlayer.shared.stopSound()
            }
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
        
        allHistoryCount = realmController.realm.objects(History.self).count
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

