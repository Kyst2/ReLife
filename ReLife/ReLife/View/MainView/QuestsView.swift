import Foundation
import SwiftUI

struct QuestsView:View {
    var body: some View {
        ScrollView{
            Sectinos(header: "Today's Quests")
            Sectinos(header: "Tomorrow's Quests")
            Sectinos(header: "Long-term Quests")
        }
        
    }
}

extension QuestsView {
    func Sectinos(header: String) -> some View {
        Section(header: Text(header).foregroundColor(Color("textColor"))) {
            ForEach(quests.indices, id: \.self) { index in
                let quest = quests[index]
                
                HStack {
                    Image(systemName: quest.icon)
                        .foregroundColor(Color("textColor"))
                        .font(.largeTitle)
                    
                    Text(quest.name)
                        .font(.headline)
                    Spacer()
                    Text(quest.deteils)
                        .foregroundColor(Color("textColor"))
                        .font(.subheadline)
                    //                                if quest.isCompleted {
                    //                                    Image(systemName: "checkmark.circle.fill")
                    //                                        .foregroundColor(.green)
                    //                                }
                }
                .padding(10)
                
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.primary, lineWidth: 0.08)
                )
                
                .onTapGesture(count: 2) {
                    // Show confirmation screen
                }
                .contextMenu {
                    Button(action: {
                        //                                    toggleCompletion(for: index)
                    }) {
                        Text(
                            //                                        quest.isCompleted ?
                            "Mark as Incomplete")
                        Image(systemName:
                                //                                            quest.isCompleted ?
                              "arrow.uturn.left.circle")
                    }
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
