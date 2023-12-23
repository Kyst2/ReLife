import Foundation
import SwiftUI

struct BtnOpenTemplatesSheet: View {
    var body: some View {
        Button {
            GlobalDialog.shared.dialog = .view(view: AnyView(SheetAddStandardData() ))
        } label: {
            Text("key.main.quests.create-using-templates".localized)
        }
        .buttonStyle(.link)
    }
}
