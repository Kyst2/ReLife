import SwiftUI
import KystParallax
import MoreSwiftUI

struct MainView: View {
    @ObservedObject var dialogModel = GlobalDialog.shared
    
    var body: some View {
        ZStack{
//            LinearGradient(colors: [Color("Back"),Color("gradient1")], startPoint: .top, endPoint: .bottom)
//            RadialGradient(colors: [Color("Back"),Color("gradient3")], center: .center , startRadius: 100, endRadius: 500).offset(x: 70)
            
//            Color("Back")
            
            TabBar()
        }
        .preferredColorScheme(.dark)
        .sheet(sheet: dialogModel.dialog)
        
    }
}

