import Foundation
import SwiftUI
import MoreSwiftUI

struct PreludeView: View {
    @State var page: PreludePage = .p1
    
    var body: some View {
        VStack {
            Space(20)
            
            switch page {
            case.p1:
                PreludeP1View()
            case .p2:
                PreludeP2View()
            case .p3:
                PreludeP3View()
            case .p4:
                PreludeP4View()
            }
            
            Spacer()
            
            Buttons()
        }
        .padding(20)
        .frame(width: 450, height: 500)
        .foregroundColor(RLColors.brownLight)
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
            page = .p4
        case .p4:
            Config.shared.preludePassed.value = true
            GlobalDialog.close()
        }
    }
    
    func prev() {
        switch page {
        case .p4:
            page = .p3
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
            
            OneCircle(filled: self.page != .p1)
                .makeFullyIntaractable()
                .onTapGesture {
                    withAnimation {
                        self.page = .p2
                    }
                }
            
            OneCircle(filled: self.page == .p4 || self.page == .p3)
                .makeFullyIntaractable()
                .onTapGesture {
                    withAnimation {
                        self.page = .p3
                    }
                }
            
            OneCircle(filled: self.page == .p4)
                .makeFullyIntaractable()
                .onTapGesture {
                    withAnimation {
                        self.page = .p4
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
    case p1, p2, p3, p4
}
