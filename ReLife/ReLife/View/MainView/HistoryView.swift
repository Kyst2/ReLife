import SwiftUI

struct HistoryView: View {
    var body: some View {
        ScrollView{
            HistoryPanel()
        }
    }
    func HistoryPanel() -> some View {
        ForEach(hiss.indices, id: \.self) { index in
            let his = hiss[index]
            HistoryItem(name: his.name)
        }
    }
}

/////////////////
///HELPERS
////////////////

struct HistoryItem: View {
    let name: String
    
    var body: some View {
        HStack{
            
            Text(name)
                .myFont(size: 15, textColor: .blue)
            Spacer()
        }
        .padding()
        .overlay{
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.primary, lineWidth: 0.1)
        }
    }
}

/////////////////////////
///TEMP
/////////////////////////
class His {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

var hiss = [His(name: "clean room"), His(name: "wash up"), His(name: "cook dinner ")]
