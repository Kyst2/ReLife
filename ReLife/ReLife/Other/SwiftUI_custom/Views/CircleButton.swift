import Foundation
import SwiftUI
import MoreSwiftUI

struct CircleButton: View {
    let icon: String
    let iconSize: CGFloat
    let iconColor: Color
    let action: () -> ()
    
    var body: some View {
        Button(action: action ) {
            Text.sfIcon(icon, size: iconSize)
                .fontWeight(.bold)
                .frame(width: 40, height: 40)
                .foregroundColor(iconColor)
                .background{
                    Circle()
                        .fill(NSColor.controlColor.color)
                        .shadow(color: .black, radius: 2)
                }
        }
        .buttonStyle(BtnUksStyle.default)
    }
}
