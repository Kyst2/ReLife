import SwiftUI
import MoreSwiftUI

struct SheetConfirmationView: View {
    
    
    var body: some View {
        VStack{
            Text("Have you completed the quest?")
            
            HStack{
                Button("yes", action: { GlobalDialog.shared.dialog = .none })
                Button("No", action: { GlobalDialog.shared.dialog = .none })
            }
        }
        .padding()
    }
}
//
//struct SheetConfirmationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SheetConfirmationView()
//    }
//}
