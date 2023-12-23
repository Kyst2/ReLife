import SwiftUI
import MoreSwiftUI

struct ItemEdit: View {
    @State var name: String
    @State var icon: MyIcon
    @State var deteils: String = ""
    @State var pointa: Int = 0
    
    let action: () -> Void
    
    @State private var isHovering = false
    
    var body: some View {
        ItemPanel()
            .overlay {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
            .background( isHovering ? Color.gray.opacity(0.5) : Color.clear )
            .padding(5)
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
            
            Image(systemName: icon.rawValue)
                .font(.largeTitle)
                .padding(10)
            
            Text(name)
                .myFont(size: 15)
            
            Spacer()
        }
    }
}