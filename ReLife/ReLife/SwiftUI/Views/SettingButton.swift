import SwiftUI

struct SettingButton: View {
    let label: String
    let action: () -> Void
    
    var body: some View{
        Button( action: action ) {
            HStack {
                Text(label)
                    .foregroundColor(Color("iconColor"))
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
