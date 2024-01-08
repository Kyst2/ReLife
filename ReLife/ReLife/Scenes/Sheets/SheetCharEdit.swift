import Foundation
import SwiftUI
import MoreSwiftUI


struct SheetCharEdit: View {
    @State var name: String
    var body: some View {
        VStack {
            TextField("Don't let me empty!", text: $name)
                .textFieldStyle(.roundedBorder)
            
            ButtonsPanel()
        }
//        .frame(height:)
    }
}


extension SheetCharEdit {
    func ButtonsPanel() -> some View {
        HStack{
            Button {
                GlobalDialog.shared.dialog = .none
            } label: {
                Text("key.sheet.yes".localized)
                    .foregroundStyle(RLColors.brownLight)
                    
                
            }
            .frame(width: 60 ,height: 40)
            .background{
                RoundedRectangle(cornerRadius: 8)
                Color.black.opacity(0.9)
            }
            
            
            
            
//            Button {
//                
//            } label: {
//                Text("key.sheet.no")
//            }
        }
    }
}
