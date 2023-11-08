import SwiftUI
import MoreSwiftUI

struct ConfigQuestView: View {
    var body: some View {
        VStack {
            BodyScrollQuests()
            
            Spacer()
            
            AddButton {
                let sheet = AnyView( QuestsCreateSheet())
                
                GlobalDialog.shared.dialog = .view(view: sheet)
            }
        }
    }
}





/////////////////
///HELPERS
/////////////////
fileprivate extension ConfigQuestView {
    func BodyScrollQuests() -> some View {
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
            ForEach(quests.indices, id: \.self) { index in
                let quest = quests[index]
                
                QuestSettingView(name: quest.name, icon: quest.icon , deteils: quest.deteils)
            }
        }
    }
}


/// мабуть прывесты в порядок
struct QuestSettingView: View {
    @State var name: String
    @State var icon: String
    @State var deteils: String
    
    @State private var isHovering = false
    
    var body: some View {
        HStack{
            Space(5)
            
            Image(systemName: icon)
                .foregroundColor(Color("iconColor"))
                .font(.largeTitle)
            
            Text(name)
                .foregroundColor(Color("textColor"))
                .font(.custom("MontserratRoman-Regular", size: 15))
            
            Spacer()
        }
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.primary, lineWidth: 0.1)
        }
        .background( isHovering ? Color.gray.opacity(0.5) : Color.clear )
        .onHover { hover in
            withAnimation(.easeOut(duration: 0.2 )){
                self.isHovering = hover
            }
        }
        .onTapGesture(count: 2) {
            let sheet = AnyView(QuestsEditSheet())
            
            GlobalDialog.shared.dialog = .view(view: sheet)
        }
    }
}
