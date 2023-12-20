import Foundation
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        hackToInitializeStaticValuesOnAppStart()
    }
}

func hackToInitializeStaticValuesOnAppStart() {
    // bugfix: incorrect UI refresh on locale change from "system" to any other
    let _ = SettingsViewModel.shared
}
