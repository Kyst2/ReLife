import Foundation
import SwiftUI
import MoreSwiftUI

struct AchievementListView: View {
    var body: some View {
        ScrollView {
            Space(20)
            
            LazyVStack(spacing: 20) {
                ForEach(allAchievements, id: \.self) { item in
                    AchievementView(model: item )
                }
            }.padding(.horizontal, 20)
            
            Space(20)
        }
        .frame(minWidth: 690)
    }
}

let allAchievements = AchievementEnum.allCases.map{ $0.asAchievement() }
