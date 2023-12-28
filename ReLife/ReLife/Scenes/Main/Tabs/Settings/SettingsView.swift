import Foundation
import SwiftUI
import MoreSwiftUI

struct SettingsView: View {
    @ObservedObject var model = SettingsViewModel.shared
    
    var body: some View {
        VStack(spacing: 0) {
            TabsPanel()
            
            TabContent()
                .transition(AnyTransition.move(edge: .trailing))
        }
    }
}

extension SettingsView {
    func TabsPanel() -> some View {
        HStack(spacing: 0) {
            SingleTab(.general)
            
            SingleTab(.quests)
            
            SingleTab(.characteristics)
            
            SingleTab(.history)
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

extension SettingsView {
    func SingleTab(_ curr: SettingsTab) -> some View {
        Text(curr.rawValue.localized)
            .myFont(size: 17)
            .frame(height: 40)
            .frame(minWidth: 150, maxWidth: .infinity)
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
                                .transition(.scale.combined(with: .opacity))
                        }
                    }
                }
                .animation(.easeInOut, value: model.tab)
            }
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.2 )){
                    model.tab = curr
                }
            }
    }
}
