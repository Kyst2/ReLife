import SwiftUI

@main
struct ReLifeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate : AppDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
