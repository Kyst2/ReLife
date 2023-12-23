import SwiftUI

struct SettingButton: View {
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(label)
                .frame(height: 25)
        })
    }
}
