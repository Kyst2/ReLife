import Foundation
import SwiftUI
import MoreSwiftUI

struct PreludeP1View: View {
    var body: some View {
        VStack{
            Spacer()
            
            Button("X") {
                GlobalDialog.close()
            }
            
            Spacer()
        }
    }
}
