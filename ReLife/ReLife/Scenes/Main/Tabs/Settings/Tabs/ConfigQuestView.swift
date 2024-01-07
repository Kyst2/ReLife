import SwiftUI
import MoreSwiftUI

struct ConfigQuestView: View {
    @ObservedObject var model: SettingsViewModel
    var body: some View {
        VStack {
            BodyScrollQuests(quests: model.allQuests)//TODO: Rename me
            
            Spacer()
            
            ButtonsPanel()
        }.padding(7)
            .contextMenu{
                Button {
                    
                } label: {
                    Text("Delete all quests")
                }
                Button {
                    
                } label: {
                    Text("Reset to default quests")
                }
            }
    }
}

extension ConfigQuestView {
    func ButtonsPanel() -> some View {
        AddButton {
            let sheet = AnyView( SheetQuestEditorView(model: model, type: .questCreator, quest: nil, action: {
                
            }))
            
            GlobalDialog.shared.dialog = .view(view: sheet)
        }.padding(10)
    }
}

/////////////////
///HELPERS
/////////////////
fileprivate extension ConfigQuestView {
    func BodyScrollQuests(quests:[Quest]) -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                ForEach(quests) { quest in
                    QuestEdit(name: quest.name, icon: quest.icon,color: Color(nsColor: quest.colorHex.asNSColor())){
                        let sheet = AnyView(SheetQuestEditorView(model: model, type: .questEditor, quest: quest, action: {
                            
                        }))
                        
                        GlobalDialog.shared.dialog = .view(view: sheet)
                    }.contextMenu {
                        Button {
                            model.deleteQuest(quest: quest)
                        } label: {
                            Text("Delete")
                        }
                    }
                }
            }
        }
    }
}
