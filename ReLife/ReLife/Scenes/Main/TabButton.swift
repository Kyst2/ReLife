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
        .backgroundGaussianBlur(type: .behindWindow, material: .m5_sidebar, color: Color.black.opacity(0.17))
        
    }
}

fileprivate extension TabButton {
    func TabIcon() -> some View {
        Image(systemName: tab.icon)
            .font(.system(size: 25))
    }
    
    func TabTitle() -> some View {
        Text(tab.rawValue.localized )
            .myFont(size: 13)
            .fontWeight(.semibold)
    }
    
    func SelectionLine() -> some View {
        Rectangle()
            .frame(height: 6)
            .offset(x: selectedTab == tab ? 0 : -400 )
    }
}