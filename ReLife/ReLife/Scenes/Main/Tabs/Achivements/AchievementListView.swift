import Foundation
import SwiftUI
import MoreSwiftUI

struct AchievementListView: View {
    let columns = [ GridItem(), GridItem()]
    
    var body: some View {
        ScrollView {
            Space(20)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(allAchievements, id: \.self) { item in
                    AchievementView(model: item )
                }
            }
            
            Space(20)
        }
        .frame(minWidth: 690)
    }
}

let allAchievements = AchievementEnum.allCases.map{ $0.asAchievement() }
