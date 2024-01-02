import Foundation
import SwiftUI
import AppCoreLight

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        hackToInitializeStaticValuesOnAppStart()
    }
}

func hackToInitializeStaticValuesOnAppStart() {
    // bugfix: incorrect UI refresh on locale change from "system" to any other
    let _ = SettingsViewModel.shared
    let _ = AudioPlayer.shared
    AppCore.initAll()
}
