import Foundation
import SwiftUI
import MoreSwiftUI

struct Achievement {
    let achived: Bool
    let date = Date.now
    let type: AchievementType = AchievementType.allCases.randomElement()!
    let title = "Премія \"Чисті ікла\" року"
    let descr = "За рік не пропустити жодної чистки зубів"
    
    
    
}

struct AchievementView: View {
    var model: Achievement
    
    var body: some View {
        HStack {
            if model.achived {
                Icon()
                    .padding(25)
                
                VStack(alignment: .leading) {
                    Text(model.title)
                        .font(.custom("SF Pro", size: 17))
                    
                    Text(model.descr)
                        .multilineTextAlignment(.leading)
                        .font(.custom("SF Pro", size: 12))
                        .opacity(0.7)
                        .fixedSize(horizontal: false, vertical: true)
                    
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
        .frame(width: 320, height: 80)
        .background(model.achived ? Color(hex: 0x222222) : Color.white.opacity(0.1))
        .paddingAlt([.left,.right], value: 8)
        .opacity(model.achived ? 1 : 0.5)
    }
    
    @ViewBuilder
    func Icon() -> some View {
        Text.sfIcon2("bookmark", size: 26)
            .if( model.type != .wood) { $0.glow(type: model.type) }
            .foregroundColor(model.type.asColor())
    }
    
    func DateFinished() -> some View {
        HStack {
            Spacer()
            
            Text(model.date.string(withFormat: "YYYY.MM.dd") )
                .font(.custom("SF Pro", size: 9))
                .monospaced()
                .opacity(0.7)
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
                ShiningView(raysCount: 15)
                    .opacity(0.7)
                
                content
            }
        case .gold:
            ZStack {
                ShiningView(raysCount: 40)
                
                content
            }
        }
    }
}


fileprivate struct ShiningView: View {
    let rays: [Angle]
    @State var flag = false
    
    init(raysCount: Int) {
        let angleTmp = Double(360)/Double(raysCount)
        
        self.rays = Array(0..<raysCount).map{ Angle.degrees( (Double($0) * angleTmp) + 30 ) }
    }
        
    var body: some View {
        ZStack {
            ForEach(rays, id: \.self) { rayAngle in
                YellowLine(min: 5, max: 15)
                    .offset(x: 30)
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

enum AchievementType: CaseIterable {
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
