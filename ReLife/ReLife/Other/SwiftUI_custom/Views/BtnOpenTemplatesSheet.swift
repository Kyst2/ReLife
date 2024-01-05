import Foundation
import SwiftUI
import MoreSwiftUI

struct BtnOpenTemplatesSheet: View {
    var body: some View {
        Button {
            GlobalDialog.shared.dialog = .view(view: AnyView(SheetAddStandardData() ))
        } label: {
            Text("key.main.quests.create-using-templates".localized)
                .fontWeight(.heavy)
                .foregroundColor(RLColors.brown)
        }
        .buttonStyle(BtnUksStyle.default)
    }
}
