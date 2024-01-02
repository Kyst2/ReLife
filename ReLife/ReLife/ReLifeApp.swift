import SwiftUI
import AppCoreLight

@main
struct ReLifeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate : AppDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .commands {
            ReplaceMenus()
        }
    }
}


struct ReplaceMenus: Commands {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Commands {
        CommandGroup(replacing: .newItem) { }
        
        CommandGroup(replacing: .help) { }
        
        CommandGroup(replacing: CommandGroupPlacement.appInfo) {
            Button("key.settings.about".localized(Bundle.main.appName)) {
                let view = AnyView( SheetAbout() )
                GlobalDialog.shared.dialog = .view(view: view)
            }
            
            Button("key.settings".localized) {
                AppCore.signals.send(signal: RLSignal.SwitchTab(tab: .settings))
            }
            .keyboardShortcut(",", modifiers: [.command])
        }
        
    }
}
