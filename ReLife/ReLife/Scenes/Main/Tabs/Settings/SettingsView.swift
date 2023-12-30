import Foundation
import SwiftUI
import MoreSwiftUI

struct SettingsView: View {
    @ObservedObject var model = SettingsViewModel.shared
    
    var body: some View {
        HStack(spacing: 0) {
            TabsPanel()
                .backgroundGaussianBlur(type: .behindWindow, material: .m2_menu, color: .black.opacity(0.2))
                .transition( .move(edge: .leading) )
            
            TabContent()
                .transition(AnyTransition.move(edge: .trailing))
        }
    }
}

extension SettingsView {
    func TabsPanel() -> some View {
        VStack(spacing: 0) {
            SingleTab(.general)
            
            SingleTab(.quests)
            
            SingleTab(.characteristics)
            
            SingleTab(.history)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func TabContent() -> some View {
        switch model.tab {
        case .general:
            ConfigGeneralView(model: model)
        case .quests:
            ConfigQuestView(model: model)
        case .characteristics:
            ConfigCharacteristicsView(model: model)
        case .history :
            HistoryView()
        }
    }
}

//////////////////////////////
///HELPERS
//////////////////////////////

enum SettingsTab: String {
    case general = "key.settings.tab.general"
    case quests = "key.quests"
    case characteristics = "key.characteristics"
    case history = "key.history"
}

extension SettingsTab {
    func asIcon() -> String {
        switch self {
        case .general:
            return "gear.badge.checkmark"
        case .quests:
            return "list.bullet.clipboard"
        case .characteristics:
            return "person"
        case .history:
            return "book"
        }
    }
}




extension SettingsView {
    func SingleTab(_ curr: SettingsTab) -> some View {
        Text.sfIcon2(curr.asIcon(), size: 25)
            .padding(12)
            .makeFullyIntaractable()
            .overlay {
                Rectangle()
                    .stroke(Color.primary, lineWidth: 0.1)
            }
            .overlay {
                VStack {
                    VStack{
                        Spacer()
                        
                        if model.tab == curr {
                            RoundedRectangle(cornerRadius: 0)
                                .fill(RLColors.brownLight)
                                .frame(height: 3)
                                .id("SettingTabSelection")
                                .transition(.move(edge: .leading).combined(with: .opacity))
                        }
                    }
                }
                .animation(.easeInOut(duration: 0.1), value: model.tab)
            }
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.3 )){
                    model.tab = curr
                }
            }
    }
}
