import SwiftUI

struct CharacteristicsView: View {
    @ObservedObject var model : MainViewModel
    
    var body: some View {
        ScrollView {
            LazyCharacteristics()
        }
    }
}


extension CharacteristicsView {
    func LazyCharacteristics() -> some View {
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
            ForEach(char.sorted {$0.name > $1.name}, id: \.self) { char in
                Charact(name: char.name, icon: char.icon, points: char.points)
            }
        }
//        ForEach(quests.indices, id: \.self) { index in
//            let quest = quests[index]
//            
//            QuestAccordeonView(isFinishable: isFinishable, repetsCount: model.realmController.getFinishCountQuest(quest: quest), quest: quest){
//                model.addToHistory(quest: quest)
//            }
//            
//        }
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
        .padding(.leading,10)
    }
}

//// ///////////////
/// TEMP
////////////////////
//
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
