import SwiftUI
import KystParallax
import MoreSwiftUI

struct MainView: View {
    var body: some View {
        ZStack{
//            LinearGradient(colors: [Color("Back"),Color("gradient1")], startPoint: .top, endPoint: .bottom)
//            RadialGradient(colors: [Color("Back"),Color("gradient3")], center: .center , startRadius: 100, endRadius: 500).offset(x: 70)
            
//            Color("Back")
//            ParallaxLayer(image: Image("depth-1"),speed: 10).offset(x: 70)
//            ParallaxLayer(image: Image("depth-2"),speed: 20).offset(x: 70)
//            ParallaxLayer(image: Image("depth-3"),speed: 30).offset(x: 70)
            TabBar()
        }
        .preferredColorScheme(.dark)
        
    }
}


