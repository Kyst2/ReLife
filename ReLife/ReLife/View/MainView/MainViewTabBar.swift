import SwiftUI
import MoreSwiftUI

struct TabBar: View {
    @State var selectedTab: MainViewTab = .Quests
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [Color("Back"),Color("gradient3")], center: .center , startRadius: 100, endRadius: 500).offset(x: 70)
            HStack(alignment: .top, content: {
                TabsPanel()
                
                ContentPanel()
            })
        }
    }
    
    func TabsPanel() -> some View {
        ZStack(alignment: .top){
            VisualEffectView(type:.behindWindow, material: .m4_headerView)
                .frame(width:120)
            VStack(spacing: 0 ){
                TabButton(tab: .Quests, selectedTab: $selectedTab)
                TabButton(tab: .Characteristics, selectedTab: $selectedTab)
                TabButton(tab: .History, selectedTab: $selectedTab)
                TabButton(tab: .Settings, selectedTab: $selectedTab)
            }
        }
    }
    
    @ViewBuilder
    func ContentPanel() -> some View {
        switch(selectedTab){
        case .Quests : QuestsView()
        case .Characteristics : CharacteristicsView()
        case .History :Text("History").fillParent()
        case .Settings: Text("Settings").fillParent()
        }
    }
}

///////////////////////
///HELPERS
//////////////////////

struct TabButton: View {
    let tab: MainViewTab
    
    @Binding var selectedTab: MainViewTab
    
    var body: some View {
        Button {
            withAnimation( .easeIn(duration: 0.2 )) { selectedTab = tab}
        } label: { ButtonLabel() }
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.primary, lineWidth: 0.1)
        )
        .buttonStyle(PlainButtonStyle())
    }
    
    func ButtonLabel() -> some View {
        ZStack {
            VisualEffectView(type:.behindWindow, material: .m4_headerView)
            
            VStack(spacing: 6){
                Image(systemName: tab.icon)
                    .font(.system(size: 25))
                    .foregroundColor(.white)
//                    .foregroundColor(Color("textColor"))
                Text(tab.title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("textColor"))
            }
        }
        .padding(.bottom,8)
        .frame(width: 120,height: 70)
        .contentShape(Rectangle())
        .background(Color("textColor").offset(x: selectedTab == tab ? 0 : -120))
    }
}

enum MainViewTab: String {
    case Quests
    case Characteristics
    case History
    case Settings
}

extension MainViewTab{
    var title: String {
        self.rawValue
    }
    
    var icon: String {
        switch self {
        case .Quests:           return "list.bullet.clipboard"
        case .Characteristics:  return "medal"
        case .History:          return "book.circle"
        case .Settings:         return "gearshape.circle"
        }
    }
}
