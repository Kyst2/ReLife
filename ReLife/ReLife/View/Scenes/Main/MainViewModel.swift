import Foundation
import Essentials

class MainViewModel: ObservableObject {
    @Published var selectedTab: MainViewTab = .Quests
    
    @Published var questToday: [Quest] = []
    @Published var questTomorrow: [Quest] = []
    @Published var questLongTerm: [Quest] = []
    
    init() {
        let c1 = Characteristic(name: "Health")
        let c2 = Characteristic(name: "Level")
        
        var charachSet = [Characteristic : Int]()
        charachSet[c1] = 15
        charachSet[c2] = 30
        
        let quest = Quest(name: "Quest", icon: .backpack, color: .green, charachPoints: charachSet, questRepeatStr: .dayOfMonth(days: [1,2]))
        
        questToday.append(quest)
        questTomorrow.append(quest)
        questLongTerm.append(quest)
        
        
        refreshData()
    }
    
    func refreshData() {
        
    }
}
