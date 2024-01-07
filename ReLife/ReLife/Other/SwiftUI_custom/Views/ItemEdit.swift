import SwiftUI
import MoreSwiftUI

struct ItemEdit: View {
    @State var name: String
    @State var icon: QuestIcon
    @State var deteils: String = ""
    @State var pointa: Int = 0
    
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
            Space(5)
            
            Text.sfIcon2(icon.rawValue, size: 25)
//            Image(systemName: icon.rawValue)
//                .font(.largeTitle)
            
            Text(name)
                .myFont(size: 15)
            
            Spacer()
        }
        .frame(height: 40)
    }
}
