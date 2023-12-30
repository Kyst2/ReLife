import Foundation
import SwiftUI
import MoreSwiftUI

struct PreludeView: View {
    @State var page: PreludePage = .p1
    
    var body: some View {
        VStack {
            switch page {
            case.p1:
                PreludeP1View()
            case .p2:
                PreludeP1View()
            case .p3:
                PreludeP1View()
            }
            
            Spacer()
            
            Buttons()
        }
        .frame(width: 400, height: 600)
    }
    
}

//////////////////////////
///HELPERS
/////////////////////////

fileprivate extension PreludeView {
    func next() {
        switch page {
        case .p1:
            page = .p2
        case .p2:
            page = .p3
        case .p3:
            GlobalDialog.close()
        }
    }
    
    func prev() {
        switch page {
        case .p3:
            page = .p2
        case .p2:
            page = .p1
        case .p1:
            break;
        }
    }
}

fileprivate extension PreludeView {
    func Buttons() -> some View {
        HStack {
            CircleButton(icon: "arrowtriangle.backward", iconSize: 19, iconColor: NSColor.controlTextColor.color, action: prev)
                .opacity(self.page == .p1 ? 0.8 : 1)
                .disabled(self.page == .p1)
            
            Circles()
            
            CircleButton(icon: "arrowtriangle.right", iconSize: 19, iconColor: NSColor.controlTextColor.color, action: next)
        }
        .padding(15)
    }
    
    func Circles() -> some View {
        HStack {
            OneCircle(filled: true)
                .makeFullyIntaractable()
                .onTapGesture {
                    withAnimation {
                        self.page = .p1
                    }
                }
            
            OneCircle(filled: self.page == .p2 || self.page == .p3)
                .makeFullyIntaractable()
                .onTapGesture {
                    withAnimation{
                        self.page = .p2
                    }
                }
            
            OneCircle(filled: self.page == .p3)
                .makeFullyIntaractable()
                .onTapGesture {
                    withAnimation {
                        self.page = .p3
                    }
                }
        }
        .frame(width: 90, height: 15)
        .padding(20)
        .animation(.easeInOut, value: self.page)
    }
}

fileprivate struct OneCircle: View {
    let filled: Bool
    
    var body: some View {
        Circle()
            .strokeBorder(RLColors.brown, lineWidth: 1.5)
            .if(filled) {
                $0.background {
                    Circle().foregroundColor(RLColors.brownLight)
                }
            }
    }
}

enum PreludePage {
    case p1, p2, p3
}
