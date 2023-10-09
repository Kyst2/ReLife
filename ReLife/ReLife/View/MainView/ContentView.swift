import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
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

    @State var selectedTab = "Quests"
    var body: some View {
        HStack(alignment: .center, content: {
            VStack(spacing: 0 ){
                
                InsideTabBar(selectedTab: $selectedTab)
                
            }
            switch(selectedTab){
            case "Quests" : QuestsView()
            case "Characteristics" : CharacteristicsView()
            default:
                QuestsView()
            }
//            .background(Color("Back"))
        })
        
    }
}
struct InsideTabBar: View{
    @Binding var selectedTab: String
    var body: some View{
        Group{

            TabButton(image: "list.bullet.clipboard", title: "Quests", selectedTab: $selectedTab)
            TabButton(image: "medal", title: "Characteristics", selectedTab: $selectedTab)
            TabButton(image: "book.circle", title: "History", selectedTab: $selectedTab)
            TabButton(image: "gearshape.circle", title: "Settings", selectedTab: $selectedTab)
        }
    }
}

struct TabButton: View {
    var image:String
    var title: String
    @Binding var selectedTab: String
    @State var isButton = false
    var body: some View {
        
        Button {
            withAnimation(.easeInOut){selectedTab = title}
        } label: {
            VStack(spacing: 6){
                
                Image(systemName: image)
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    
            }
            .padding(.bottom,8)
            .frame(width: 100, height: 55 + self.getSafeAreaBottom() )
            .contentShape(Rectangle())
            .background(Color("textColor").offset(x: selectedTab == title ? 0 : -100))
        }
        .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.primary, lineWidth: 0.1)
                )
        .buttonStyle(PlainButtonStyle())

    }
}
extension View {
    func getScreen() -> CGRect {
        return NSScreen.main!.visibleFrame
    }
    
    func getSafeAreaBottom() -> CGFloat{
        return 10
    }
}
