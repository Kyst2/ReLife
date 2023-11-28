import SwiftUI
import MoreSwiftUI
import KystParallax

struct TabBar: View {
    @State var selectedTab: MainViewTab = .Quests
    
    var body: some View {
        ZStack{
            BackgroundView()
            
            HStack(alignment: .top, spacing: 0) {
                TabsPanel()
               
                ContentPanel()
            }
        }
    }
    
}

extension TabBar {
    @ViewBuilder
    func BackgroundView() -> some View {
        RadialGradient(colors: [Color("Back"),Color("gradient3")], center: .center , startRadius: 50, endRadius: 400).offset(x: 70)
        
        ParallaxLayer(image: Image("Stars1"),speed: 2).fillParent()
        
        ParallaxLayer(image: Image("Stars2"),speed: 7).fillParent()
    }
    
    func TabsPanel() -> some View {
        ZStack(alignment: .top){
            VisualEffectView(type:.behindWindow, material: .m5_sidebar)
                .frame(width:120)
            
            Color("blurColor")
                .opacity(0.5)
                .frame(width: 120)
            
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
        case .Characteristics : CharacteristicsView().fillParent()
        case .History : HistoryView().fillParent()
        case .Settings: SettingsView()
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
            .buttonLabelModifier()
    }
    
    func ButtonLabel() -> some View {
        ZStack {
            BattonBackground()
            
            VStack(spacing: 6){
                TabIcon()
                    
                TabTitle()
            }
        }
        .tabButtonModifier(selectedTab: selectedTab, tab: tab)
        
    }
}
extension TabButton {
    @ViewBuilder
    func BattonBackground() -> some View {
        VisualEffectView(type:.behindWindow, material: .m5_sidebar)
        
        Color("blurColor")
            .opacity(0.5)
    }
    
    func TabIcon() -> some View {
        Image(systemName: tab.icon)
            .myImageColor()
            .font(.system(size: 25))
    }
    
    func TabTitle() -> some View {
        Text(tab.title)
            .myFont(size: 13, textColor: .blue)
            .fontWeight(.semibold)
    }
}
////////////////
///HELPERS
////////////////
fileprivate extension View {
    func tabButtonModifier(selectedTab: MainViewTab , tab: MainViewTab) -> some View {
        self
            .padding(.bottom,8)
            .frame(width: 120,height: 70)
            .contentShape(Rectangle())
            .background(Color("tabLineColor").offset(x: selectedTab == tab ? 0 : -120))
    }
    
    func buttonLabelModifier() -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.primary, lineWidth: 0.1)
            )
            .buttonStyle(PlainButtonStyle())
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
        case .History:          return "book"
        case .Settings:         return "gearshape"
        }
    }
}
