import SwiftUI
import MoreSwiftUI

struct ConfigCharacteristicsView: View {
    var body: some View {
        bodyScrollCharacteristics()
        Spacer()
        AddButton {
            
        }
    }
}


/////////////////
///HELPERS
/////////////////
fileprivate extension ConfigCharacteristicsView {
    func bodyScrollCharacteristics() -> some View {
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
            ForEach(char.indices, id: \.self) { index in
                let char = char[index]
                CharactSettingView(name: char.name, icon: char.icon, points: char.points)
            }
        }
    }
}


struct CharactSettingView : View {
    @State private var hoverEffect = false
    
    @State var name: String
    @State var icon: String
    @State var points: Int
    var body: some View {
        HStack{
            Space(5)
            Image(systemName: icon)
                .foregroundColor(Color("iconColor"))
                .font(.largeTitle)
            
            Text(name)
                .foregroundColor(Color("textColor"))
                .font(.custom("MontserratRoman-Regular", size: 15))
            Spacer()
        }.padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
            .background( hoverEffect ? Color.gray.opacity(0.5) : Color.clear )
            .onHover{ hover in
                withAnimation(.easeOut(duration: 0.2 )){
                    self.hoverEffect = hover
                }
            }
            .onTapGesture(count: 2) {
                
                ///open settings view for element
            }
    }
}
