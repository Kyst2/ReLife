import Foundation
import SwiftUI
import Essentials
import MoreSwiftUI

struct SheetFanfareView: View {
    @ObservedObject var model: SheetFanfareViewModel
    
    let timer = TimerPublisher(every: 0.07)
    
    init(quest: Quest) {
        model = SheetFanfareViewModel(quest)
    }
    
    var body: some View {
        CharacteristicsList(charsAndPoints: $model.charsAndPoints, spacings: false)
            .paddingAlt([.all], value: 30)
            .frame(minWidth: 400, minHeight: 300)
            .background {
                AuroraClouds(blur: 20, theme: AuroraTheme.reLifeAchievement)
            }
            .onReceive(timer) { _ in
                model.charsAndPoints.indices.forEach { idx in
                    if model.charsAndPoints[idx].points < model.charsAndPointsGoal[idx].points {
                        model.charsAndPoints[idx].points += 1
                    }
                }
            }
            .onTapGesture {
                if !model.charsAndPoints.isEqual(to: model.charsAndPointsGoal) {
                    model.charsAndPoints = model.charsAndPointsGoal
                } else {
                    GlobalDialog.close()
                }
            }
    }
}

class SheetFanfareViewModel: ObservableObject {
    @Published var charsAndPoints: [CharacteristicsAndPoints]
    @Published var charsAndPointsGoal: [CharacteristicsAndPoints]
    
    init (_ quest: Quest) {
        let tmp = RealmController.shared.getAllCharacteristicPoints()
        self.charsAndPoints = tmp
        var tmpCharsAndPointsGoal = tmp
        
        let questCharachPoints = quest.charachPoints.map{ ($0.key, $0.value) }
        
        questCharachPoints.forEach { questChPoints in
            guard let item = tmpCharsAndPointsGoal.filter({ $0.charac.key == questChPoints.0 }).first,
                  let idx = tmpCharsAndPointsGoal.firstIndex(of: item)
            else { return }
            
            tmpCharsAndPointsGoal[idx].points = item.points + questChPoints.1
        }
        
        charsAndPointsGoal = tmpCharsAndPointsGoal
    }
}

fileprivate extension Array where Element == CharacteristicsAndPoints {
    func isEqual(to: [CharacteristicsAndPoints]) -> Bool {
        for idx in indices {
            if self[idx] != to[idx] {
                return false
            }
        }
        
        return true
    }
}
