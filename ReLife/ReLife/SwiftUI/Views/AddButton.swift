import SwiftUI

struct AddButton: View {
    let action: () -> Void
    
    var body: some View{
        Button( action: action ) {
            Image(systemName: "plus")
                .font(.largeTitle)

        }
    }
}
