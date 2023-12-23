import Foundation
import SwiftUI
import MoreSwiftUI

struct AchievementView: View {
    let achived: Bool
    let date = Date.now
    
    var body: some View {
        HStack {
            if achived {
                Icon()
                    .padding(15)
                
                VStack(alignment: .leading) {
                    Text("Чисті ікла")
                        .font(.custom("SF Pro", size: 20))
                    
                    Spacer()
                    
                    DateFinished()
                }
                .padding(.vertical, 12)
                
                Spacer()
            } else {
                Text("?")
                    .font(.custom("SF Pro", size: 35))
            }
        }
        .frame(width: 280, height: 80)
        .background(achived ? Color.gray : Color.white.opacity(0.1))
        .paddingAlt([.left,.right], value: 8)
        .opacity(achived ? 1 : 0.5)
    }
    
    @ViewBuilder
    func Icon() -> some View {
        if achived {
            Color.red
                .frame(width: 50, height: 50)
                .glow()
        } else {
            Color.red
                .frame(width: 50, height: 50)
        }
    }
    
    func DateFinished() -> some View {
        HStack {
            Spacer()
            
            Text(date.string(withFormat: "YYYY.MM.dd") )
                .font(.custom("SF Pro", size: 9))
                .monospaced()
                .opacity(0.7)
        }
    }
}

extension View {
    func glow() -> some View {
        modifier(GlowModifier())
    }
}

struct GlowModifier: ViewModifier {
    @State private var throb = false
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: throb ? 10 : 2)
                .animation(.easeOut(duration: 2).repeatForever(), value: throb)
                .onAppear {
                    throb.toggle()
                }
            
            content
        }
    }
}


