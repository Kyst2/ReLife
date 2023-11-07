import SwiftUI
import MoreSwiftUI

struct ConfigQuestView: View {
    
    @State private var dialog: SheetDialogType = .none
    
    var body: some View {
        VStack {
            bodyScrollQuests()
            
            Spacer()
            
            AddButton {
               
                
            }
        }
    }
}





/////////////////
///HELPERS
/////////////////
fileprivate extension ConfigQuestView {
    func bodyScrollQuests() -> some View {
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
            ForEach(quests.indices, id: \.self) { index in
                let quest = quests[index]
                QuestSettingView(name: quest.name, icon: quest.icon , deteils: quest.deteils)
            }
        }
    }
}

struct QuestSettingView: View {
    @State private var hoverEffect = false
    @State private var dialog: SheetDialogType = .none
    @State var name: String
    @State var icon: String
    @State var deteils: String
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
        }.padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
            .background( hoverEffect ? Color.gray.opacity(0.5) : Color.clear )
            .onHover{ hover in
                withAnimation(.easeOut(duration: 0.2 )){
                    self.hoverEffect = hover
                }
            }
            .sheet(sheet: dialog)
            .onTapGesture(count: 2) {
                let sheet = AnyView(QuestsEditSheet(dialog: $dialog, name: $name, icon: $icon, deteils: $deteils))
                
                dialog = .view(view: sheet)
                ///open settings view for element
            }
    }
}
