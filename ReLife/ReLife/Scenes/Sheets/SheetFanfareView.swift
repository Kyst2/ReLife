import Foundation
import SwiftUI
import Essentials

struct SheetFanfareView: View {
    @ObservedObject var model: SheetFanfareViewModel
    
    let timer = TimerPublisher(every: 0.3)
    
    init(quest: Quest) {
        model = SheetFanfareViewModel(quest)
    }
    
    var body: some View {
        CharacteristicsList(charsAndPoints: $model.charsAndPoints, spacings: false)
//            .frame(minWidth: 300, minHeight: 250)
//            .padding(30)
            .onReceive(timer) { _ in
                model.charsAndPoints.indices.forEach { idx in
                    if model.charsAndPoints[idx].points <= model.charsAndPointsGoal[idx].points {
                        model.charsAndPoints[idx].points += 1
                    }
                }
            }
    }
}

class SheetFanfareViewModel: ObservableObject {
    @Published var charsAndPoints: [CharacteristicsAndPoints]
    @Published var charsAndPointsGoal: [CharacteristicsAndPoints]
    
    init (_ quest: Quest) {
        self.charsAndPoints = RealmController.shared.getAllCharacteristicPoints()
        var tmpCharsAndPointsGoal = RealmController.shared.getAllCharacteristicPoints()
        
        quest.charachPoints.forEach { questChPoints in
            guard let item = tmpCharsAndPointsGoal.filter({ $0.id.uuidString == questChPoints.key }).first,
                  let idx = tmpCharsAndPointsGoal.firstIndex(of: item)
            else { return }
            
            tmpCharsAndPointsGoal[idx].points = item.points + questChPoints.value
        }
        
        charsAndPointsGoal = tmpCharsAndPointsGoal
    }
}
