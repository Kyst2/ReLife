import SwiftUI
import MoreSwiftUI

struct SheetConfirmationView: View {
    var body: some View {
        VStack{
            Text("Have you completed the quest?")
            
            HStack{
                Button("Yes", action: { GlobalDialog.shared.dialog = .none })
                Button("No", action: { GlobalDialog.shared.dialog = .none })
            }
        }
        .padding()
    }
}
