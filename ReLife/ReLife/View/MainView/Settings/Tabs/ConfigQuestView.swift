import SwiftUI
import MoreSwiftUI

struct ConfigQuestView: View {
    var body: some View {
        VStack {
            BodyScrollQuests()
            
            Spacer()
            
            ButtonsPanel()
        }
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
            
            SettingButton(label: "Reset to default quests") {
                
            }
        }
    }
}

/////////////////
///HELPERS
/////////////////
fileprivate extension ConfigQuestView {
    func BodyScrollQuests() -> some View {
        ScrollView{
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
