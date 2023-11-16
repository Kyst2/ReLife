import SwiftUI
import MoreSwiftUI

struct ConfigCharacteristicsView: View {
    var body: some View {
        bodyScrollCharacteristics()
        
        Spacer()
        
        AddButton {
            
        }
    }
}


/////////////////
///HELPERS
/////////////////
fileprivate extension ConfigCharacteristicsView {
    func bodyScrollCharacteristics() -> some View {
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
