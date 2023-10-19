import SwiftUI
import KystParallax

struct MainView: View {
    var body: some View {
        ZStack{
            TabBar()
            ParallaxLayer(image: Image("depth-1"),speed: 10)
            ParallaxLayer(image: Image("depth-2"),speed: 20)
            ParallaxLayer(image: Image("depth-3"),speed: 30)
        }
        
    }
}


