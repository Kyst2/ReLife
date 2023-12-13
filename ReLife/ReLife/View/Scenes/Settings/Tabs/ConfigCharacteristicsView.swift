import SwiftUI
import MoreSwiftUI

struct ConfigCharacteristicsView: View {
    @ObservedObject var model: SettingsViewModel
    
    var body: some View {
        VStack{
            bodyScrollCharacteristics()
            
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
    func bodyScrollCharacteristics() -> some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                ForEach(char.indices, id: \.self) { index in
                    let char = char[index]
                    
                    //                    ItemEdit(name: char.name, icon: char.icon){
                    //                        let sheet = AnyView(SheetWorkWithQuest(type: .characteristicEdit, action: {
                    //
                    //                        }))
                    //
                    //                        GlobalDialog.shared.dialog = .view(view: sheet)
                    //                    }.contextMenu{
                    //                        Button {
                    //
                    //                        } label: {
                    //                            Text("Delete")
                    //                        }
                
                    
                }
            }
        }
    }
    
    func ButtonsPanel() -> some View {
        AddButton {
            let sheet = AnyView( SheetWorkWithQuest(model: model, type: .characteristicCreator, action: {
                
            }))
            
            GlobalDialog.shared.dialog = .view(view: sheet)
        }.padding(10)
    }
}
