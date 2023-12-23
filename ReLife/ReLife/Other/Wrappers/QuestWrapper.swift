import Foundation

struct QuestWrapper: Equatable , Identifiable {
    var id = UUID()
    
    let quest: Quest
    let finishedTimes: Int
}
