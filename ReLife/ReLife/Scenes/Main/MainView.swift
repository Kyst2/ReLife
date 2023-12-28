import SwiftUI
import MoreSwiftUI
import KystParallax

struct MainView: View {
    @ObservedObject var model = MainViewModel()
    @ObservedObject var dialogModel = GlobalDialog.shared
    
    let transition = [
        AnyTransition.move(edge: .trailing),
        AnyTransition.push(from: .trailing)
    ].shuffled().first!
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VerticalTabs()
                .frame(width: 70)
            
            ContentPanel()
                .fillParent()
                .frame(minWidth: 700)
        }
        .foregroundColor(RLColors.brownLight)
        .background( BackgroundView().opacity(0.3) )
        .preferredColorScheme(.dark)
        .sheet(sheet: dialogModel.dialog)
        .wndAccessor{ $0?.title = "" }
    }
}

extension MainView {
    @ViewBuilder
    func BackgroundView() -> some View {
        ParallaxLayer(image: Image("Stars1"), speed: 2).fillParent()
        
        ParallaxLayer(image: Image("Stars2"), speed: 7).fillParent()
        
        ParallaxLayer(image: Image("Stars3"), speed: 10).fillParent()
    }
    
    @ViewBuilder
    func VerticalTabs() -> some View {
        HStack(spacing: 0) {
            VStack(spacing: 0 ) {
                TabButton(tab: .quests, selectedTab: $model.selectedTab)
                
                TabButton(tab: .characteristics, selectedTab: $model.selectedTab)
                
                #if DEBUG
                TabButton(tab: .achivements, selectedTab: $model.selectedTab)
                    .opacity(0.5)
                #endif
                
                TabButton(tab: .settings, selectedTab: $model.selectedTab)
                
                Spacer()
            }
            .id(MainViewTab.quests.rawValue.localized) //fix refresh issues on locale change
            .backgroundGaussianBlur(type:.behindWindow, material: .m5_sidebar, color: Color.black.opacity(0.1))
            
            Divider()
        }
    }
    
    @ViewBuilder
    func ContentPanel() -> some View {
        switch(model.selectedTab){
        case .quests : 
            QuestsView(model: model)
                .transition(transition)
        case .characteristics :
            CharacteristicsView(model: model)
                .transition(transition)
        case .achivements:
            AchievementListView()
                .transition(transition)
        case .settings:
            SettingsView()
        }
    }
}

///////////////////////
///HELPERS
//////////////////////

enum MainViewTab: String {
    case quests = "key.quests"
    case characteristics = "key.characteristics"
    case achivements = "key.achievements"
    case settings = "key.settings"
}

extension MainViewTab {
    var icon: String {
        switch self {
        case .quests:           return "list.bullet.clipboard"
        case .characteristics:  return "person"
        case .achivements:      return "medal"
        case .settings:         return "gearshape"
        }
    }
}
