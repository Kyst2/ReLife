import SwiftUI
import MoreSwiftUI

struct ColorPicker: View {
    @Binding var color: UInt32
    @State private var colorPickerShown = false
    
//    let allIcons = MyIcon.allCases.map{ $0.rawValue }
    let allColor = pickerColors
    
    let columns = (1...10).map { _ in GridItem(.fixed(35)) }
    
    var body: some View {
        PopoverButt(edge: .leading, isPresented: $colorPickerShown, { Label(color) } ) {
            LazyVGrid(columns: columns, content: {
                ForEach(allColor, id: \.self ) { col in
                    Button(action: { color = col; colorPickerShown = false }) {
                        Label(col)
                            .frame(width: 30,height: 30)
                            .overlay( Selection(col: color) )
                    }
                    .buttonStyle(BtnUksStyle.default)
                }
            })
            .padding(25)
        }
        .buttonStyle(BtnUksStyle.default)
    }
    
    func Label(_ color: UInt32) -> some View {
        Circle()
            .foregroundStyle(Color(hex: color))
            .frame(width: 20,height: 20)
    }
    
    @ViewBuilder
    func Selection(col: UInt32) -> some View {
        if color == col {
            Circle()
                .stroke(Color.primary, lineWidth: 2)
        } else {
            Color.clear
        }
    }
}

private let pickerColors: [UInt32] =
[
    0x204729,
    0xe17346,
    0xf3c3b8,
    0x2c5658,
    0xd74857,
    0x6a9872,
    0xf1bd78,
    0xeacacf,
    0xa2b5da,
    0xad4438,
    0xd24972,
    0xbda1e0,
    0xddb13c,
    0x121f61,
    0x7bbaa3,
    0xe6b2bc,
    0xebc445,
    0xa7ccd9
]
