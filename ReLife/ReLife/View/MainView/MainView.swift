import SwiftUI
import KystParallax
import MoreSwiftUI

struct MainView: View {
    @ObservedObject var dialogModel = GlobalDialog.shared
    
    var body: some View {
        TabBar()
            .preferredColorScheme(.dark)
            .sheet(sheet: dialogModel.dialog)
    }
}
