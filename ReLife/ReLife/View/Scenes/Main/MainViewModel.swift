import Foundation
import Essentials

class MainViewModel: ObservableObject {
    let realmController = RealmController()
    
    @Published var selectedTab: MainViewTab = .Quests
    
    @Published var questToday: [Quest] = []
    @Published var questTomorrow: [Quest] = []
    @Published var questLongTerm: [Quest] = []
    
    func initFakeData() {
//        let c1 = Characteristic(name: "Health")
//        let c2 = Characteristic(name: "Level")
//        realmController.add(characteristic: c1)
//        realmController.add(characteristic: c2)
        
        var charachSet = [Characteristic : Int]()
        
        realmController.characteristicsAll.forEach{
            charachSet[$0] = 15
        }
        
        let quest = Quest(name: "AlmostEachDayQuest", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: .eachWeek(days: [1,2,3,4,5,6]))
        
        realmController.add(quest: quest)
    }
    
    init() {
//        initFakeData()
        
        self.questToday = realmController.getActualQuestsToday()
        self.questTomorrow = realmController.getActualQuestsToday(dateNow: Date.now.adding(days: 1) )
        self.questLongTerm = realmController.getSingleQuestHalfYear(dateNow: Date.now)
        
        refreshData()
    }
    
    func refreshData(forceRefresh: Bool = false) {
        let newQuestToday = realmController.getActualQuestsToday()
        let newQuestTomorrow = realmController.getActualQuestsToday(dateNow: Date.now.adding(days: 1) )
        let newQuestLongTerm = realmController.getSingleQuestHalfYear(dateNow: Date.now)
        
        if self.questToday != newQuestToday || self.questTomorrow != newQuestTomorrow || self.questLongTerm != newQuestLongTerm{
            self.questToday = newQuestToday
            self.questTomorrow = newQuestTomorrow
            self.questLongTerm = newQuestLongTerm
        }else {
            if forceRefresh {
                self.objectWillChange.send()
            }
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
        refreshData()
    }
}
