import Foundation
import SwiftUI
import MoreSwiftUI

struct QuestsView:View {
    var body: some View {
        ScrollView {
            Sections(header: "Today's Quests")
            Sections(header: "Tomorrow's Quests")
            Sections(header: "Long-term Quests")
        }
    }
}



extension QuestsView {
    func Sections(header:String) -> some View {
        Section(header: Text(header).foregroundColor(Color("textColor"))) {
            ForEach(quests.indices, id: \.self) { index in
                let quest = quests[index]
                CustomDisclosureView(icon: quest.icon, name: quest.name) {
                    Text(quest.deteils)
                }
            }
        }
    }
}

class Questec {
    var name: String
    var icon: String
    var deteils:String
    init(name: String, icon: String, deteils: String) {
        self.name = name
        self.icon = icon
        self.deteils = deteils
    }
}

var quests = [Questec(name: "Quest1", icon: "heart.fill" , deteils: "wash up "),Questec(name: "Quest2", icon: "heart.fill", deteils: "clean room"), Questec(name: "Quest3", icon: "heart.fill", deteils: "buy apple")]


struct CustomDisclosureView<Content: View>: View {
    @State private var isExpanded = false
    
    let icon:String
    let name:String
    let content: () -> Content
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: icon)
                    .foregroundColor(Color("textColor"))
                    .font(.largeTitle)
                
                Text(name)
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.2 )){
                        isExpanded.toggle()}
                }) {
                    Text.sfSymbol(isExpanded ? "chevron.up" : "chevron.right")
                }
                .padding(.trailing,20)
                .buttonStyle(.plain)
            }
            
            if isExpanded {
                content()
                    .padding()
            }
        }
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.primary, lineWidth: 0.1)
        }
    }
}
