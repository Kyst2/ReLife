import Foundation
import SwiftUI
import MoreSwiftUI

struct HelpBtn<Content: View>: View {
    @State var isPresented = false
    
    let content: () -> Content
    
    var body: some View {
        PopoverButt(edge: .top, isPresented: $isPresented, {
            Text.sfSymbol("questionmark.circle")
        }) {
            content()
        }
        .buttonStyle(.plain)
    }
}
