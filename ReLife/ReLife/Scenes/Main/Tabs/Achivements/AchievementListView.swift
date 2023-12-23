import Foundation
import SwiftUI
import MoreSwiftUI

struct AchievementListView: View {
    let columns = [ GridItem(), GridItem()]
    
    var body: some View {
        ScrollView {
            Space(20)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(0...100), id: \.self) { _ in
                    AchievementView(model: Achievement(achived: Bool.random()) )
                }
            }
            
            Space(20)
        }
        .frame(minWidth: 690)
    }
}
