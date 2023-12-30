import Foundation
import SwiftUI
import MoreSwiftUI

struct PreludeP1View: View {
    @ObservedObject var model = SettingsViewModel.shared
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("AppIconNoGlow")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
            
            HStack {
                Text.sfIcon2(RLIcons.language, size: 20)
                
                LanguagePicker(currLang: $model.currLang)
            }
            
            Spacer()
        }
    }
}
