import Foundation
import Essentials

class MainViewModel: ObservableObject {
    let realmController = RealmController()
    
    @Published var selectedTab: MainViewTab = .Quests
    
    @Published var questToday: [QuestWrapper] = []
    @Published var questTomorrow: [QuestWrapper] = []
    @Published var questLongTerm: [QuestWrapper] = []
    
    @Published var characteristics: [Characteristic] = []
    
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
        deleteAllHistory()
//        initFakeData()
        
        refreshData()
    }
    
    func refreshData(forceRefresh: Bool = false) {
        //quests
        let newQuestToday = realmController.getActualQuestsToday()
        let newQuestTomorrow = realmController.getActualQuestsToday(dateNow: Date.now.adding(days: 1))
//        let newQuestLongTerm = realmController.getSingleQuestHalfYear(dateNow: Date.now).sorted(by: {$0.name < $1.name})
        
        if self.questToday != newQuestToday {
            self.questToday = newQuestToday
        }
        if self.questTomorrow != newQuestTomorrow {
            self.questTomorrow = newQuestTomorrow
        }
        
//         self.questLongTerm != newQuestLongTerm{
//            
//            self.questLongTerm = newQuestLongTerm
//        } 
        else {
            if forceRefresh {
                self.objectWillChange.send()
            }
        }
        
        //characteristics
        let newCharacteristics = realmController.getAllCharacteristicPoints()
        
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
    
    func deleteAllHistory() {
        realmController.deleteAllHistory()
    }
    func getAllCharacteristirs() {
        
    }
    func getCharacteriscticsAndPoints() -> [CharacteristicsAndPoints]{
        realmController.getAllCharacteristicPoints()
    }
    
}
