import Foundation
import SwiftUI
import AppCoreLight
import MoreSwiftUI

struct BtnOpenSettings: View {
    let settingsTab: SettingsTab
    
    var body: some View {
        Button {
            AppCore.signals.send(signal: RLSignal.SwitchTab(tab: .settings))
            SettingsViewModel.shared.tab = settingsTab
        } label: {
            Text("key.main.quests.HERE".localized)
                .fontWeight(.heavy)
                .foregroundColor(RLColors.brown)
        }
        .buttonStyle(BtnUksStyle.default)
    }
}
