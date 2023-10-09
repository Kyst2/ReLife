import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
//            QuestsView()
//                .background(Color("Back"))
            TabBar()
        }
    }
}
    
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

struct TabBar: View {
//    init() {
////        NSTabb
//    }
    var body: some View {
        ZStack(alignment: .bottom, content: {
            TabView {
                Color.red
                    .tag("SwiftUI")
                    .ignoresSafeArea(.all,edges: .all)
                
                Color.blue
                    .tag("Begginers")
                    .ignoresSafeArea(.all,edges: .all)
            }
            HStack(spacing: 0 ){
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45 ,height: 45 )
            }
        })
    }
}
struct TabButton: View {
    
}
