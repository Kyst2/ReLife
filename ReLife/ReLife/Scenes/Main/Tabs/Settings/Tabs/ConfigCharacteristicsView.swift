import SwiftUI
import MoreSwiftUI

struct ConfigCharacteristicsView: View {
    @ObservedObject var model: SettingsViewModel
    
    var body: some View {
        VStack{
            bodyScrollCharacteristics(characteristics: model.allCharacteristics)
            
            Spacer()
            
            ButtonsPanel()
        }.padding(7)
            .contextMenu{
                Button {
                    
                } label: {
                    Text("Delete all characteristics")
                }
                Button {
                    
                } label: {
                    Text("Reset to default characteristics")
                }
            }
    }
}

/////////////////
///HELPERS
/////////////////
fileprivate extension ConfigCharacteristicsView {
    func bodyScrollCharacteristics(characteristics: [Characteristic]) -> some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                ForEach(characteristics) { char in
                    
//                    CharacteristicEdit(name: char.name, icon: char.icon, point: char.points) {
//                        
//                    }
//                    ItemEdit(name: char.name, icon: ){
////                        let sheet = AnyView()
//                        
////                        GlobalDialog.shared.dialog = .view(view: sheet)
//                    }.contextMenu{
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
    
    func ButtonsPanel() -> some View {
        AddButton {
//            let sheet = AnyView( SheetWorkWithQuest(model: model, type: .characteristicCreator, quest: <#T##Quest#>, action: <#T##() -> Void#>) )
            
//            let sheet = AnyView( SheetWorkWithQuest(model: model, type: .characteristicCreator, action: {
//                
//            }))
//            
//            GlobalDialog.shared.dialog = .view(view: sheet)
        }.padding(10)
    }
}
