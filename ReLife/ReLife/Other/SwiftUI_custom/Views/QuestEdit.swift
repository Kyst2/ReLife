import SwiftUI
import MoreSwiftUI

struct QuestEdit: View {
    @State var name: String
    @State var icon: QuestIcon
    @State var deteils: String = ""
    @State var pointa: Int = 0
    @State var color: Color
    
    let action: () -> Void
    
    @State private var isHovering = false
    
    var body: some View {
        ItemPanel()
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .fill( isHovering ? Color.gray.opacity(0.1) : Color.clear)
            }
            .onHover { hover in
                withAnimation(.easeOut(duration: 0.2 )){
                    self.isHovering = hover
                }
            }
            .onTapGesture(count: 2) {
                action()
            }
    }
    
    func ItemPanel() -> some View {
        HStack{
            Space(10)
            
            Text.sfIcon2(icon.rawValue, size: 25)
                .foregroundStyle(color)

            
            Text(name)
                .myFont(size: 15)
                .foregroundStyle( RLColors.brownLight )
            
            Spacer()
        }
        .frame(height: 40)
    }
}
