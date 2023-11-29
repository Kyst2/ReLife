import SwiftUI
import MoreSwiftUI

struct ConfigQuestView: View {
    var body: some View {
        VStack {
            BodyScrollQuests()//TODO: Rename me
            
            Spacer()
            
            ButtonsPanel()
        }
        .padding(7)
    }
}

extension ConfigQuestView {
    func ButtonsPanel() -> some View {
        HStack{
            AddButton {
                let sheet = AnyView( SheetWorkWithQuest(type: .questCreator, action: {
                    
                }))
                
                GlobalDialog.shared.dialog = .view(view: sheet)
            }
            
            SettingButton(label: "Reset to default quests") {//TODO: change button text
                
            }
        }
    }
}

/////////////////
///HELPERS
/////////////////
fileprivate extension ConfigQuestView {
    func BodyScrollQuests() -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                ForEach(quests.indices, id: \.self) { index in
                    let quest = quests[index]
                    
                    ItemEdit(name: quest.name, icon: quest.icon){
                        let sheet = AnyView(SheetWorkWithQuest(type:.questEditor, action: {
                            
                        }))
                        
                        GlobalDialog.shared.dialog = .view(view: sheet)
                    }
                }
            }
        }
    }
}
