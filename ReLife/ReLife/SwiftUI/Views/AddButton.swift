import SwiftUI

struct AddButton: View {
    let action: () -> Void
    
    var body: some View{
        Button( action: action ) {
            Image(systemName: "plus")
                .myImageColor()
                .font(.largeTitle)
                .frame(width: 400,height: 40)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color("blurColor")).opacity(0.8)
                }
        }
        .buttonStyle(.plain)
        .fixedSize()
        .frame(maxWidth: .infinity)
    }
}
