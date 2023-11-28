
import SwiftUI

/// привести в порядок
struct AddButton: View {
    let action: () -> Void
    
    var body: some View{
        Button( action: action ) {
            HStack {
                Image(systemName: "plus")
                    .myImageColor()
                    .font(.largeTitle)
            }
        }
        .buttonStyle(.plain)
        .frame(width: 400,height: 40)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color("blurColor")).opacity(0.8)
        }
        .padding(20)
        .fixedSize()
        .frame(maxWidth: .infinity)
        
    }
}


