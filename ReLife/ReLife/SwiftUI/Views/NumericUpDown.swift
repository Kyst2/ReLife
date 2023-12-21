import Foundation
import SwiftUI

struct NumericUpDown: View {
    @Binding var value: Int
    
    var body: some View {
        HStack(spacing: 1) {
            TextField("", value: $value, formatter: NumberFormatter())
                .multilineTextAlignment(.center)
                .onChange(of: value) { newValue in
                    self.value = min(max(newValue, 1), 700)
                }
            
            VStack(spacing:0.1) {
                Button(action: { self.value += 1 } ) {
                    UpDownBtnLbl(isUp: true)
                }
                
                Button(action: { self.value -= 1 } ) {
                    UpDownBtnLbl(isUp: false)
                }
            }
            .buttonStyle(.plain)
        }
    }
}

fileprivate struct UpDownBtnLbl: View {
    let isUp: Bool
    
    var symbol: String { isUp ? "chevron.up" : "chevron.down" }
    let rounded: CGFloat = 5
    
    var body: some View {
        Text.sfSymbol(symbol)
            .font(.system(size: 8).weight(.heavy))
            .padding(EdgeInsets(horizontal: 1.5, vertical: 0.2))
            .background{
                Rectangle()
                    .fill( Color(nsColor: NSColor.controlColor ) )
                    .clipShape(
                        .rect(
                            topLeadingRadius: isUp ? rounded : 0,
                            bottomLeadingRadius: isUp ? 0 : rounded,
                            bottomTrailingRadius: isUp ? 0 : rounded,
                            topTrailingRadius: isUp ? rounded : 0
                        )
                    )
            }
    }
}
