import SwiftUI
import MoreSwiftUI

struct ConfigCharacteristicsView: View {
    var body: some View {
        bodyScrollCharacteristics()
        
        Spacer()
        
        ButtonsPanel()
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
                    
                    ItemEdit(name: char.name, icon: char.icon){
                        let sheet = AnyView(SheetWorkWithQuest(type: .characteristicEdit, action: {
                            
                        }))
                        
                        GlobalDialog.shared.dialog = .view(view: sheet)
                    }
                }
            }
        }
    }
    
    func ButtonsPanel() -> some View {
        HStack{
            AddButton {
                let sheet = AnyView( SheetWorkWithQuest(type: .characteristicCreator, action: {
                    
                }))
                
                GlobalDialog.shared.dialog = .view(view: sheet)
            }
            
            SettingButton(label: "Reset to default characteristics") {
                
            }
        }
    }
}
