import SwiftUI

struct QuestsView:View {
        var body: some View {
            ScrollView{
                Sectinos(header: "Today's Quests", questIcon: "Icon", questName: "Name", questDeteils: "Deteils")
                Sectinos(header: "Tomorrow's Quests", questIcon: "Icon", questName: "Name", questDeteils: "Deteils")
                Sectinos(header: "Long-term Quests", questIcon: "Icon", questName: "Name", questDeteils: "Deteils")
            }
        }
    }
    
extension QuestsView {
    func Sectinos(header: String , questIcon: String , questName: String,questDeteils:String) -> some View {
        Section(header: Text(header).foregroundColor(Color("textColor"))) {
            //                        ForEach(quests.indices, id: \.self) { index in
            //                            let quest = quests[index]
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color("textColor"))
                    .font(.largeTitle)
                Text(questName)
                    .font(.headline)
                Spacer()
                Text(questDeteils)
                    .foregroundColor(Color("textColor"))
                    .font(.subheadline)
                //                                if quest.isCompleted {
                //                                    Image(systemName: "checkmark.circle.fill")
                //                                        .foregroundColor(.green)
                //                                }
            }
            .padding()
            .background(Color("Back"))
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
