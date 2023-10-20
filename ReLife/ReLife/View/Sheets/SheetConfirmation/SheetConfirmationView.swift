import SwiftUI
import MoreSwiftUI

struct SheetConfirmationView: View {
    @Binding var dialog: SheetDialogType
    
    var body: some View {
        VStack{
            Text("Are You Sure?")
            
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
