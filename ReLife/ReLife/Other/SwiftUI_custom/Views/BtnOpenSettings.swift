import Foundation
import SwiftUI
import AppCoreLight

struct BtnOpenSettings: View {
    let settingsTab: SettingsTab
    
    var body: some View {
        Button {
            MyApp.signals.send(signal: RLSignal.SwitchTab(tab: .settings))
            SettingsViewModel.shared.tab = settingsTab
        } label: {
            Text("key.main.quests.HERE".localized)
        }
        .buttonStyle(.link)
    }
}
