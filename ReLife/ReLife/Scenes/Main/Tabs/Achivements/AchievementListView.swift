import Foundation
import SwiftUI
import MoreSwiftUI

struct AchievementListView: View {
    let myAchievements = allAchievements//.mySorted()
    
    var body: some View {
        ScrollView {
            Space(20)
            
            LazyVStack(spacing: 20) {
                ForEach(myAchievements, id: \.self) { item in
                    AchievementView(model: item )
                }
            }.padding(.horizontal, 20)
            
            Space(20)
        }
        .frame(minWidth: 690)
    }
}

let allAchievements = AchievementEnum.allCases.map{ $0.asAchievement() }

/////////////////////////
///HELPERS
/////////////////////////

fileprivate extension Array where Element == Achievement {
    func mySorted() -> [Achievement] {
        self.sorted {
            if $0.finished.int != $1.finished.int {
                return $0.finished.int > $1.finished.int
            }
            
            if $0.type.rawValue != $1.type.rawValue {
                return $0.type.rawValue < $1.type.rawValue
            }
            
            return true
        }
    }
}

fileprivate extension Bool {
    var int: Int {
        self == true ? 1 : 0
    }
}
