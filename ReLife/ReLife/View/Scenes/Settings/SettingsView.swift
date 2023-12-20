import Foundation
import SwiftUI
import MoreSwiftUI

struct SettingsView: View {
    @ObservedObject var model = SettingsViewModel.shared
    
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
            ConfigTabView(tab: $model.tab, curr: .general)
            
            ConfigTabView(tab: $model.tab, curr: .quests)
            
            ConfigTabView(tab: $model.tab, curr: .characteristics)
        }
    }
    
    @ViewBuilder
    func TabsBody() -> some View {
        switch model.tab {
        case .general:
            ConfigGeneralView(model: model)
        case .quests:
            ConfigQuestView(model: model)
        case .characteristics:
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
            Text(curr.rawValue.localized)
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
