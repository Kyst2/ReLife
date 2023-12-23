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
            .padding(.leading, 20)
        }
    }
}

/////////////////
///HELPERS
/////////////////

struct Charact: View {
    var name: String
    var icon: String
    var points: Int
    
    var body: some View {
        HStack(spacing: 20) {
            Icon()
                
            Text(name)
            
            Spacer()
            
            Text("\(points)")
        }
        .font(.custom("SF Pro", size: 17).weight(.bold) )
        .foregroundColor(Color(hex: 0xc0baaf))
        .padding(.vertical, 2)
    }
    
    func Icon() -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color(hex: 0xae8b63))
                .font(.largeTitle)
        }.frame(width: 20)
    }
}
