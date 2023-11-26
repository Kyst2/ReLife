import SwiftUI
import MoreSwiftUI

struct SheetConfirmationView: View {
    let text: String
    let action: () -> Void
    var body: some View {
        VStack{
            Text(text)
            
            HStack{
                Button("Yes", action: {
                    action()
                    GlobalDialog.shared.dialog = .none
                })
                Button("No", action: { GlobalDialog.shared.dialog = .none })
            }
        }
        .frame(width: 300 , height: 200)
        .backgroundGaussianBlur(type: .behindWindow , material: .m1_hudWindow)
        
    }
}
