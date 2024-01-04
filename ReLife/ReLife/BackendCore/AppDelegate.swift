import Foundation
import SwiftUI
import AppCoreLight
import AppReview

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        hackToInitializeStaticValuesOnAppStart()
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        AppReview.requestIf(launches: 1)
    }
}

func hackToInitializeStaticValuesOnAppStart() {
    // bugfix: incorrect UI refresh on locale change from "system" to any other
    let _ = SettingsViewModel.shared
    let _ = AudioPlayer.shared
    AppCore.initAll()
}
