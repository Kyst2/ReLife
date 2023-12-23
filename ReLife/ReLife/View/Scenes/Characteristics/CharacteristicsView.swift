import SwiftUI
import MoreSwiftUI

struct CharacteristicsView: View {
    @ObservedObject var model : MainViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            if model.allCharacCount == 0 {
                NoCharacteristicView()
            } else {
                CharacteristicsList()
            }
        }
    }
}

extension CharacteristicsView {
    func NoCharacteristicView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text("key.main.quests.you-can-create-charac".localized)
                    BtnOpenSettings(settingsTab: .characteristics)
                }
                
                HStack(spacing: 0) {
                    Text("key.main.quests.create-using".localized)
                    BtnOpenTemplatesSheet()
                }
            }
            .padding(20)
            .fixedSize()
            
            Spacer()
        }
        .font(.custom("SF Pro", size: 15))
    }
    
    func BackgroundView() -> some View {
        HStack{
            Spacer()
            
            Image("AppIconNoGlow")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .shadow(color: .white, radius: 4)
                .opacity(0.8)
                .padding(.trailing, 25)
        }
    }
    
    @ViewBuilder
    func CharacteristicsList() -> some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(model.characteristicsAndPoints) { wrapper in
                        Charact(name: wrapper.charac.name, icon: wrapper.charac.icon, points: wrapper.points)
                    }
                }
                .frame(maxWidth: 300)
                .padding(.top, 40)
                
                Space(min:300)
            }
        }
    }
}

/////////////////
///HELPERS
/////////////////

struct Charact: View {
    var name: String
    var icon:String
    var points:Int
    
    var body: some View {
        HStack {
            ImagePanel()
                
            NamePanel()
            
            Spacer()
            
            PointsPanel()
        }
    }
    
    func ImagePanel() -> some View {
        Image(systemName: icon)
            .myImageColor()
            .font(.largeTitle)
            .padding(10)
    }
    
    func NamePanel() -> some View {
        Text(name)
            .font(.custom("SF Pro", size: 17).weight(.bold) )
//            .foregroundColor()
//            .myFont(size: 17, textColor: .blue)
            .padding(10)
    }
    
    func PointsPanel() -> some View {
        Text("\(points)")
            .myFont(size: 17, textColor: .white).italic()
            .padding(.trailing,20)
    }
}
