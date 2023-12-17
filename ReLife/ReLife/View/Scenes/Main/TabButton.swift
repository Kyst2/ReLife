import SwiftUI
import MoreSwiftUI

struct TabButton: View {
    let tab: MainViewTab
    @Binding var selectedTab: MainViewTab
    
    var body: some View {
        Button(action: btnAction, label: BtnLabel )
            .buttonStyle(PlainButtonStyle())
    }
    
    func btnAction() {
        withAnimation( .easeIn(duration: 0.2 )) { selectedTab = tab }
    }
    
    func BtnLabel() -> some View {
        VStack(spacing: 0) {
            Space(10)
            
            TabIcon()
            
            Space(8)
                
            TabTitle()
            
            Space(8)
            
            SelectionLine()
            
            Divider()
        }
        .backgroundGaussianBlur(type: .behindWindow, material: .m5_sidebar, color: Color("blurColor").opacity(0.1))
        .frame(width: 120)
    }
}

fileprivate extension TabButton {
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
    
    func SelectionLine() -> some View {
        Rectangle()
            .fill(Color("iconColor"))
            .frame(height: 6)
            .offset(x: selectedTab == tab ? 0 : -120)
    }
}
