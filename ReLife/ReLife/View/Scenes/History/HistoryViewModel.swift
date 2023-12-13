import Foundation

class HistoryViewModel: ObservableObject {
    let realmController = RealmController()
    @Published var history:[History] = []
    
    init() {
        refreshHistory()
    }
    func refreshHistory() {
        let newHistory = realmController.allHistory
        if history != newHistory {
            self.history = newHistory
        }
    }
}
