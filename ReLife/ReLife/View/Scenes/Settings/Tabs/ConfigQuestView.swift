import SwiftUI
import MoreSwiftUI

struct ConfigQuestView: View {
    var body: some View {
        VStack {
            BodyScrollQuests()//TODO: Rename me
            
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
            let sheet = AnyView( SheetWorkWithQuest(type: .questCreator, action: {
                
            }))
            
            GlobalDialog.shared.dialog = .view(view: sheet)
        }.padding(10)
    }
}

/////////////////
///HELPERS
/////////////////
fileprivate extension ConfigQuestView {
    func BodyScrollQuests() -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
//                ForEach(quests.indices, id: \.self) { index in
//                    let quest = quests[index]
//                    
//                    ItemEdit(name: quest.name, icon: quest.icon){
//                        let sheet = AnyView(SheetWorkWithQuest(type:.questEditor, action: {
//                            
//                        }))
//                        
//                        GlobalDialog.shared.dialog = .view(view: sheet)
//                    }.contextMenu {
//                        Button {
//                            
//                        } label: {
//                            Text("Delete")
//                        }
//
//                    }
//                }
            }
        }
    }
}
