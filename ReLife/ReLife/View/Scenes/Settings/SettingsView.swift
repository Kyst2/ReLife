import Foundation
import SwiftUI
import MoreSwiftUI

struct SettingsView: View {
    @State fileprivate var tab: SettingsTab = .General
    @ObservedObject var model = SettingsViewModel()
    
    var body: some View {
        VStack(spacing: 0){
            TabsPanel()
            
            TabsBody()
        }
    }
}

extension SettingsView {
    func TabsPanel() -> some View {
        HStack(spacing: 0) {
            ConfigTabView(tab: $tab, curr: .General)
            
            ConfigTabView(tab: $tab, curr: .Quests)
            
            ConfigTabView(tab: $tab, curr: .Characteristics)
        }
    }
    
    @ViewBuilder
    func TabsBody() -> some View {
        switch tab {
        case .General:
            ConfigGeneralView(model: model)
        case .Quests:
            ConfigQuestView(model: model)
        case .Characteristics:
            ConfigCharacteristicsView(model: model)
        }
    }
}




/////////////////
///HELPERS
/////////////////
//TODO: fix button to fill parent
struct ConfigTabView: View {
    @Binding fileprivate var tab: SettingsTab
    fileprivate let curr: SettingsTab
    
    var body: some View {
        Button(action: {
            withAnimation(.easeIn(duration: 0.2 )){
                tab = curr
            }
        }) {
            Text(curr.rawValue)
                .myFont(size: 18, textColor: .blue)
                .menuBttonModifier(tab: tab, curr: curr)
        }
        .buttonStyle(.plain)
    }
}

fileprivate extension View {
    func menuBttonModifier(tab: SettingsTab,curr:SettingsTab) -> some View{
        self.frame(height: 40)
            .frame(minWidth: 200,maxWidth: .infinity)
            .contentShape(Rectangle())
            .background {
                tab == curr ? Color.gray.opacity(0.5) : Color.clear
            }
            .overlay {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
    }
}

fileprivate enum SettingsTab: String {
    case General
    case Quests
    case Characteristics
}
