import Foundation
import Essentials
import AppCoreLight
import SwiftUI
import AsyncNinja

class MainViewModel: NinjaContext.Main, ObservableObject {
    let realmController = RealmController.shared
    
    @Published var selectedTab: MainViewTab = .quests
    
    @Published var questToday: [QuestWrapper] = []
    @Published var questTomorrow: [QuestWrapper] = []
    @Published var questLongTerm: [QuestWrapper] = []
    
    @Published var characteristicsAndPoints: [CharacteristicsAndPoints] = []
    
    @Published var allQuestsCount: Int = 0
    @Published var allCharacCount: Int = 0
    
    
    override init() {
        super.init()
        
        refreshData()
        
        AppCore.signals.subscribeFor( RLSignal.LanguageChaned.self )
            .onUpdate { _ in self.objectWillChange.send() }
        
        AppCore.signals.subscribeFor( RLSignal.ReloadData.self )
            .onUpdate { _ in self.refreshData(forceRefresh: true) }
        
        AppCore.signals.subscribeFor(RLSignal.SwitchTab.self )
            .onUpdate { tab in
                withAnimation {
                    self.selectedTab = tab.tab
                }
            }
        
        $selectedTab.asyncNinja
            .onUpdate { _ in
                AudioPlayer.shared.stopSound()
            }
    }
    
    func refreshData(forceRefresh: Bool = false) {
        //quests
        let newQuestToday = realmController.getActualQuestsToday()
        let newQuestTomorrow = realmController.getActualQuestsToday(dateNow: Date.now.adding(days: 1))
        let newQuestLongTerm = realmController.getSingleQuestHalfYear(dateNow: Date.now)
        
        if self.questToday != newQuestToday {
            self.questToday = newQuestToday
        }
        if self.questTomorrow != newQuestTomorrow {
            self.questTomorrow = newQuestTomorrow
        }
        if self.questLongTerm != newQuestLongTerm{
            
            self.questLongTerm = newQuestLongTerm
        } 
        else {
            if forceRefresh {
                self.objectWillChange.send()
            }
        }
        
        //characteristics
        let newCharacteristicsAndPoints = realmController.getAllCharacteristicPoints()
        if self.characteristicsAndPoints != newCharacteristicsAndPoints {
            self.characteristicsAndPoints = newCharacteristicsAndPoints
        }
        
        allQuestsCount  = realmController.realm.objects(Quest.self).count
        allCharacCount  = realmController.realm.objects(Characteristic.self).count
    }
    
    func addQuest(quest:Quest) {
        realmController.add(quest: quest)
        refreshData()
    }
    
    func removeQuest(questKey: String) {
        realmController.remove(questKey: questKey)
        refreshData()
    }
    
    func addToHistory(quest:Quest) {
        realmController.add(history: History(quest: quest, dateCompleted: Date.now))
        refreshData(forceRefresh: true)
    }
    
    func getCharacteriscticsAndPoints() -> [CharacteristicsAndPoints]{
        realmController.getAllCharacteristicPoints()
    }
}
