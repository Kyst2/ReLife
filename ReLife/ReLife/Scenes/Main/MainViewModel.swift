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
    
    func reInitFakeData() {
        realmController.deleteAllOf(type: Quest.self)
        realmController.deleteAllOf(type: Characteristic.self)
        realmController.deleteAllOf(type: History.self)
        
        let c1 = Characteristic(name: "Health", icon: "figure.mind.and.body")
        let c2 = Characteristic(name: "Tidiness", icon: "laurel.trailing")
        let c3 = Characteristic(name: "Athleticism", icon: "figure.cooldown")
        let c4 = Characteristic(name: "Mind", icon: "brain")
        realmController.add(characteristic: c1)
        realmController.add(characteristic: c2)
        realmController.add(characteristic: c3)
        realmController.add(characteristic: c4)
        
        var charachSet = [Characteristic : Int]()
        
        realmController.characteristicsAll.forEach{
            charachSet[$0] = Array(15...50).randomElement()
        }
        
        let quest = Quest(name: "AlmostEachDayQuest", icon: .backpack, color: .orange, charachPoints: charachSet, questRepeatStr: .eachWeek(days: [1,2,3,4,5,6,7]))
        let quest2 = Quest(name: "AlmostEachDayQuest2", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: .eachWeek(days: [1,2,3,4,5,6,7]))
        let quest3 = Quest(name: "AlmostEachDayQuest3", icon: .backpack, color: .white, charachPoints: charachSet, questRepeatStr: .eachWeek(days: [1,2,3,4,5,6,7]))
        
        realmController.add(quest: quest)
        realmController.add(quest: quest2)
        realmController.add(quest: quest3)
    }
    
    override init() {
        super.init()
        
        reInitFakeData()
        
        refreshData()
        
        MyApp.signals.subscribeFor( RLSignal.LanguageChaned.self )
            .onUpdate { _ in self.objectWillChange.send() }
        
        MyApp.signals.subscribeFor( RLSignal.ReloadData.self )
            .onUpdate { _ in self.refreshData(forceRefresh: true) }
        
        MyApp.signals.subscribeFor(RLSignal.SwitchTab.self )
            .onUpdate { tab in
                withAnimation {
                    self.selectedTab = tab.tab
                }
            }
        
        $selectedTab.asyncNinja
            .onUpdate { _ in
                stopSound()
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
