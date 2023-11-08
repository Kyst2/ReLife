import Foundation
import SwiftUI
import MoreSwiftUI

fileprivate enum SettingsTab: String {
    case General
    case Quests
    case Characteristics
}

struct SettingsView: View {
    @State fileprivate var tab: SettingsTab = .General
    
    var body: some View {
        VStack(spacing: 15){
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
            ConfigGeneralView()
        case .Quests:
            ConfigQuestView()
        case .Characteristics:
            ConfigCharacteristicsView()
        }
    }
}




/////////////////
///HELPERS
/////////////////
struct ConfigTabView: View {
    @Binding fileprivate var tab: SettingsTab
    fileprivate let curr: SettingsTab
    
    var body: some View {
        MenuButton(lebel: curr.rawValue ) {
            tab = curr
        }.background{
            tab == curr ? Color.gray.opacity(0.5) : Color.clear
        }
    }
}



/// привести в порядок 
fileprivate struct MenuButton: View {
    let lebel: String
    let action: () -> Void
    var body: some View {
        Button {
            withAnimation(.easeIn(duration: 0.2 )){
                action()
            }
        } label: {
            Text(lebel)
                .foregroundColor(Color("textColor"))
                .font(.custom("MontserratRoman-Regular", size: 18))
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.primary, lineWidth: 0.1)
        }
    }
}
