import SwiftUI

struct SettingButton: View {
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(label) {
            action()
        }
    }
}
