import SwiftUI
import MoreSwiftUI

struct SheetConfirmationView: View {
    @Binding var dialog: SheetDialogType
    
    var body: some View {
        VStack{
            Text("Have you completed the quest?")
            
            HStack{
                Button("yes", action: { dialog = .none })
                Button("No", action: { dialog = .none })
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
