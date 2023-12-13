import SwiftUI
import Essentials

struct HistoryView: View {
    @ObservedObject var model = HistoryViewModel()
    var body: some View {
        ScrollView{
            HistoryPanel(history: model.history)
        }
    }
}

extension HistoryView {
    func HistoryPanel(history:[History]) -> some View {
        ForEach(history) { his in
            HistoryItem(quest: his.quest!, date: his.dateCompleted)
        }
    }
}

/////////////////
///HELPERS
////////////////

struct HistoryItem: View {
    let quest:Quest
    let date:Date
    
    var body: some View {
        HStack{
            Image(systemName: quest.icon.rawValue)
                .myImageColor()
                .font(.largeTitle)
                .padding(10)
            
            Text(quest.name)
                .myFont(size: 17, textColor: .blue)
            
            Spacer()
            
            Text("\(date.asString())")
                .myFont(size: 13, textColor: .white)
                .padding(10)
        }
        .overlay{
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.primary, lineWidth: 0.1)
        }
        .padding(7)
    }
}

/////////////////////////
///TEMP
/////////////////////////
//class His {
//    var name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//var hiss = [His(name: "clean room"), His(name: "wash up"), His(name: "cook dinner ")]
