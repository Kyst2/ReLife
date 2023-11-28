import SwiftUI
import MoreSwiftUI

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

fileprivate extension View {
    func tabButtonModifier(selectedTab: MainViewTab , tab: MainViewTab) -> some View {
        self.padding(.bottom,8)
            .frame(width: 120,height: 70)
            .contentShape(Rectangle())
            .background(Color("tabLineColor").offset(x: selectedTab == tab ? 0 : -120))
    }
    
    func buttonLabelModifier() -> some View {
        self.overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.primary, lineWidth: 0.1)
            )
            .buttonStyle(PlainButtonStyle())
    }
}
