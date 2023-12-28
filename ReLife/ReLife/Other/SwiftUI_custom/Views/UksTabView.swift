import Foundation
import SwiftUI
import MoreSwiftUI

struct UksTabView<SomeTabType, Content>: View where SomeTabType: MyCustomTab, Content: View {
    @Binding var selection: SomeTabType
    var tabSide: TabSide = .leading
    var tabSide2: TabSide2 = .center
    
    @ViewBuilder var content: () -> Content
    
    var allCases = SomeTabType.allCases.map{ $0 }
    
    var body: some View {
        switch tabSide {
        case .leading:
            LeadingView()
        case .trailing:
            TrailingView()
        case .top:
            TopView()
        case .bottom:
            BottomView()
        }
    }
    
    func LeadingView() -> some View {
        HStack {
            VStack(spacing: 0) {
                ForEach(allCases, id: \.self) { someTab in
                    someTab.asTabView(isSelected: someTab == selection)
                        .id("\(someTab.hashValue)")
                        .onTapGesture { withAnimation{ selection = someTab } }
                }
            }
            
            content()
                .fillParent()
        }
    }
    
    func TrailingView() -> some View {
        HStack {
            content()
            
            VStack(spacing: 0) {
                if tabSide2 == .end {
                    Spacer()
                }
                
                ForEach(allCases, id: \.self) { someTab in
                    someTab.asTabView(isSelected: someTab == selection)
                        .onTapGesture { selection = someTab }
                }
                
                if tabSide2 == .begin {
                    Spacer()
                }
            }
        }
    }
    
    func TopView() -> some View {
        VStack {
            HStack(spacing: 0) {
                if tabSide2 == .end {
                    Spacer()
                }
                
                ForEach(allCases, id: \.self) { someTab in
                    someTab.asTabView(isSelected: someTab == selection)
                        .onTapGesture { selection = someTab }
                }
                
                if tabSide2 == .begin {
                    Spacer()
                }
            }
            
            content()
        }
    }
    
    func BottomView() -> some View {
        VStack {
            HStack(spacing: 0) {
                if tabSide2 == .end {
                    Spacer()
                }
                
                ForEach(allCases, id: \.self) { someTab in
                    someTab.asTabView(isSelected: someTab == selection)
                        .onTapGesture { selection = someTab }
                }
                
                if tabSide2 == .begin {
                    Spacer()
                }
            }
            
            content()
        }
    }
}


enum TabSide {
    case top, bottom, leading, trailing
}

enum TabSide2 {
    case begin, center, end
}

protocol MyCustomTab: CaseIterable, Hashable {
    associatedtype Content: View
    
    func asTabView(isSelected: Bool) -> Content
}


///////////
/////////////
//public extension View {
//    func asAnyView() -> AnyView {
//        AnyView(self)
//    }
//}
