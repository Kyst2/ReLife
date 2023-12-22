import SwiftUI

struct CharacteristicsView: View {
    @ObservedObject var model : MainViewModel
    
    var body: some View {
        ZStack {
            Image("AppIconNoGlow")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .opacity(0.8)
            
            ScrollView {
                LazyCharacteristics(characteristics: model.characteristicsAndPoints)
            }
        }
    }
}


extension CharacteristicsView {
    func LazyCharacteristics(characteristics: [CharacteristicsAndPoints]) -> some View {
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
            ForEach(characteristics) { wrapper in
                Charact(name: wrapper.charac.name, icon: wrapper.charac.icon, points: wrapper.points)
            }
        }
    }
}
/////////////////
///HELPERS
/////////////////

struct Charact: View {
    var name: String
    var icon:String
    var points:Int
    
    var body: some View {
        HStack{
            ImagePanel()
                
            NamePanel()
            
            Spacer()
            
            PointsPanel()
        }
        .charactModifire()
        
    }
    
    func ImagePanel() -> some View {
        Image(systemName: icon)
            .myImageColor()
            .font(.largeTitle)
            .padding(10)
    }
    
    func NamePanel() -> some View {
        Text(name)
            .myFont(size: 17, textColor: .blue)
            .padding(10)
    }
    
    func PointsPanel() -> some View {
        Text("\(points)")
            .myFont(size: 17, textColor: .white).italic()
            .padding(.trailing,20)
    }
    
}

fileprivate extension View {
    func charactModifire() -> some View {
        self.overlay {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
        .padding(.top,5)
        .padding(.horizontal,10)
    }
}

//// ///////////////
/// TEMP
////////////////////
////
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
