import Foundation
import Essentials

class MainViewModel: ObservableObject {
    @Published var selectedTab: MainViewTab = .Quests
    
    init() {
        refreshData()
    }
    
    func refreshData() {
        
    }
}
