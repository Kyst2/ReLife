import Foundation
import Essentials

class MainViewModel: ObservableObject {
    let realmController = RealmController.shared
    
    @Published var selectedTab: MainViewTab = .quests
    
    @Published var questToday: [QuestWrapper] = []
    @Published var questTomorrow: [QuestWrapper] = []
    @Published var questLongTerm: [QuestWrapper] = []
    
    @Published var characteristicsAndPoints: [CharacteristicsAndPoints] = []
    
    func initFakeData() {
//        let c1 = Characteristic(name: "Health")
//        let c2 = Characteristic(name: "Level")
//        realmController.add(characteristic: c1)
//        realmController.add(characteristic: c2)
        
        var charachSet = [Characteristic : Int]()
        
        realmController.characteristicsAll.forEach{
            charachSet[$0] = 15
        }
        
        let quest = Quest(name: "AlmostEachDayQuest", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: .eachWeek(days: [1,2,3,4,5,6,7]))
        
        realmController.add(quest: quest)
    }
    
    init() {
//        realmController.deleteAllOf(type: History.self)
//        initFakeData()
        
        refreshData()
        
        MyApp.signals.subscribeFor( RLSignal.LanguageChaned.self )
            .onUpdate { _ in self.objectWillChange.send() }
        
        MyApp.signals.subscribeFor( RLSignal.ReloadData.self )
            .onUpdate { _ in self.refreshData(forceRefresh: true) }
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
