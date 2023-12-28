import SwiftUI
import MoreSwiftUI
import Essentials

struct HistoryView: View {
    @ObservedObject var model = HistoryViewModel()
    var body: some View {
        if model.history.count == 0 {
            Text("There are no history records at the moment")
                .fillParent()
        } else {
            ScrollView {
                VStack(spacing: 6) {
                    ForEach(model.history) { his in
                        HistoryItem(quest: his.quest!, date: his.dateCompleted)
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
            }
        }
    }
}

/////////////////
///HELPERS
////////////////

struct HistoryItem: View {
    let quest: Quest
    let date: Date
    
    @State var isHovering = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text.sfIcon2(quest.icon.rawValue, size: 20)
                    .foregroundColor(Color(nsColor: quest.colorHex.asNSColor()))
                    .padding(6)
                
                Text(quest.name)
                    .myFont(size: 17)
                    .foregroundColor(Color(nsColor: quest.colorHex.asNSColor()))
                
                Spacer()
                
                Text("\(date.asString())") // "y-M-dd HH:mm" ?????
                    .myFont(size: 13)
                    .padding(10)
            }
            
            Divider()
                .padding(.horizontal, 3)
                .opacity(isHovering ? 0 : 1)
        }
        .background { baackground() }
        .onHover { hvr in withAnimation { isHovering = hvr } }
    }
    
    func baackground() -> some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(isHovering ? Color.orange.opacity(0.05): Color.clear)
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
