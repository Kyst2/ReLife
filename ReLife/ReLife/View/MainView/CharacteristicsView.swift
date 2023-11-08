import SwiftUI

struct CharacteristicsView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                ForEach(char.sorted {$0.name > $1.name}, id: \.self) { char in
                    //        let char = char[index]
                    Charact(name: char.name, icon: char.icon, points: char.points)
                }
            }
        }
    }
}

struct Charact: View {
    var name: String
    var icon:String
    
    var points:Int
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(Color("iconColor"))
                
            
            Text(name)
                .foregroundColor(Color("textColor"))
                .font(.custom("MontserratRoman-Regular", size: 17))
            
            Spacer()
            
            Text("\(points)")
                .font(.custom("MontserratRoman-Regular", size: 17).italic())
                .padding(.trailing,20)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.primary, lineWidth: 0.1)
        }
    }
}


//// ///////////////
/// TEMP
////////////////////

class Characteristics1: Hashable {
    @Published var name: String
    @Published var icon:String
    @Published var points: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(icon)
        hasher.combine(points)
    }
    
    init(name: String, icon: String, points: Int) {
        self.name = name
        self.icon = icon
        self.points = points
    }
}

var char = [Characteristics1(name: "Health", icon: "heart.fill", points: 15),Characteristics1(name: "Strength", icon: "heart.fill", points: 50),Characteristics1(name: "Cleaner", icon: "heart.fill", points: 30)]
extension Characteristics1: Equatable {
    static func == (lhs: Characteristics1, rhs: Characteristics1) -> Bool {
        return lhs.name == rhs.name
    }
}

//// ///////////////
///PREVIEW
////////////////////
struct CharacteristicsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacteristicsView()
    }
}
