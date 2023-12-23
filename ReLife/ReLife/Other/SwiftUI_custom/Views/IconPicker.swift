import SwiftUI
import MoreSwiftUI

struct IconPicker: View {
    @Binding var icon: String
    @State private var iconPickerShown = false
    
    let allIcons = MyIcon.allCases.map{ $0.rawValue }
    
    let columns = (1...10).map { _ in GridItem(.fixed(35)) }
    
    var body: some View {
        PopoverButt(edge: .leading, isPresented: $iconPickerShown, { Label(icon) } ) {
            LazyVGrid(columns: columns, content: {
                ForEach(allIcons, id: \.self ) { image in
                    Button(action: { icon = image; iconPickerShown = false }) {
                        Label(image, size: 26)
                            .overlay( Selection(image:image).padding(-6) )
                    }
                    .buttonStyle(BtnUksStyle.default)
                }
            })
            .padding(25)
        }
        .buttonStyle(BtnUksStyle.default)
    }
    
    func Label(_ img: String, size: CGFloat = 20) -> some View {
        Text.sfIcon2(img, size: size)
    }
    
    @ViewBuilder
    func Selection(image: String) -> some View {
        if icon == image {
            Circle()
                .stroke(Color.primary, lineWidth: 2)
        } else {
            Color.clear
        }
    }
}
