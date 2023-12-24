import Foundation
import SwiftUI
import MoreSwiftUI



struct AchievementView: View {
    var model: Achievement
    
    var body: some View {
        HStack(alignment: .top) {
            Icon()
                .padding(35)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.custom("SF Pro", size: 17))
                
                Space(5)
                
                Text(model.descr)
                    .multilineTextAlignment(.leading)
                    .font(.custom("SF Pro", size: 12))
                    .opacity(0.7)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                
                DateFinished()
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .frame(minHeight: 100)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: 0x222222))
        }
        .opacity(model.finished ? 1 : 0.4)
    }
    
    @ViewBuilder
    func Icon() -> some View {
        if model.finished {
            Text.sfIcon2(model.icon, size: 26)
                .if( model.type != .wood) { $0.glow(type: model.type) }
                .foregroundColor(model.type.asColor())
        } else {
            Text("?")
                .font(.custom("SF Pro", size: 26))
                .foregroundColor(model.type.asColor())
        }
    }
    
    func DateFinished() -> some View {
        HStack {
            Spacer()
            
            Text(model.date.string(withFormat: "YYYY.MM.dd") )
                .font(.custom("SF Pro", size: 9))
                .monospaced()
                .opacity(0.7)
                .padding(5)
        }
    }
}



fileprivate extension View {
    func glow(type: AchievementType) -> some View {
        modifier(GlowModifier(type: type))
    }
}

fileprivate struct GlowModifier: ViewModifier {
    let type: AchievementType
    @State private var throb = false
    
    func body(content: Content) -> some View {
        switch type {
        case .wood:
            content
        case .silver:
            ZStack {
                Circle()
                    .fill(.black)
                    .blur(radius: 10)
                    .frame(width: 60, height: 60)
                    .padding(-20)
                    .opacity(0.7)
                    
                ShiningView(raysCount: 15, min: 10, max: 20, offset: 25)
                    .opacity(0.9)
                
                content
            }
        case .gold:
            ZStack {
                Circle()
                    .fill(.black)
                    .blur(radius: 10)
                    .frame(width: 60, height: 60)
                    .padding(-20)
                
                ShiningView(raysCount: 35, min: 5, max: 15, offset: 30)
                
                content
            }
        }
    }
}


fileprivate struct ShiningView: View {
    let rays: [Angle]
    let offset: CGFloat
    let min: CGFloat
    let max: CGFloat
    
    @State var flag = false
    
    init(raysCount: Int, min: CGFloat, max: CGFloat, offset: CGFloat) {
        self.min = min
        self.max = max
        self.offset = offset
        
        let angleTmp = Double(360)/Double(raysCount)
        
        self.rays = Array(0..<raysCount).map{ Angle.degrees( (Double($0) * angleTmp) + 30 ) }
    }
        
    var body: some View {
        ZStack {
            ForEach(rays, id: \.self) { rayAngle in
                YellowLine(min: min, max: max)
                    .offset(x: offset)
                    .rotationEffect(rayAngle)
            }
        }
        .rotationEffect(flag ? Angle(degrees: 360) : Angle(degrees: 0))
        .onAppear{
            withAnimation{
                flag.toggle()
            }
        }
        .animation(.easeInOut(duration: 120).repeatForever(), value: flag)
    }
}

fileprivate struct YellowLine: View {
    let max: CGFloat
    let animationDuration: CGFloat = [2.0, 3.0, 4.0, 5.0, 6.0].randomElement()!
    let blurRadius: CGFloat = [2.0, 3.0, 4.0, 5.0].randomElement()!
    
    @State var width: CGFloat
    
    init(min: CGFloat, max: CGFloat) {
        self.width = min
        self.max = max
    }
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: 0.5)
            .animation(.linear(duration: animationDuration).repeatForever(autoreverses: true), value: width)
            .blur(radius: blurRadius)
            .onAppear {
                width = max
            }
    }
}

enum AchievementType: Int, CaseIterable {
    case wood 
    case silver
    case gold
}

fileprivate extension AchievementType {
    func asColor() -> Color {
        switch self {
        case .wood:   return RLColors.achivementWood
        case .silver: return RLColors.achivementSilver
        case .gold:   return RLColors.achivementGold
        }
    }
}
