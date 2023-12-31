import SwiftUI
import MoreSwiftUI
import KystParallax
import AppCoreLight

struct MainView: View {
    @ObservedObject var model = MainViewModel()
    @ObservedObject var dialogModel = GlobalDialog.shared
    
    @ObservedObject var achievementEnabledCp: ConfigProperty<Bool>
    
    let transition = [
        AnyTransition.move(edge: .trailing),
        AnyTransition.push(from: .trailing)
    ].shuffled().first!
    
    
    init() {
        if Config.shared.preludePassed.value == false {
            GlobalDialog.shared.dialog = .view(view: AnyView( PreludeView() ) )
        }
        
        achievementEnabledCp = Config.shared.achievementsEnabled
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VerticalTabs()
                .frame(width: 70)
            
            ContentPanel()
                .fillParent()
        }
        .foregroundColor(RLColors.brownLight)
        .background { AuroraClouds(blur: 60, theme: AuroraTheme.reLifeMain) }
        .preferredColorScheme(.dark)
        .sheet(sheet: dialogModel.dialog)
        .wndAccessor{ $0?.title = "" }
        .frame(minWidth: 700, minHeight: 400)
    }
}

extension MainView {
//    @ViewBuilder
//    func BackgroundView() -> some View {
//        ParallaxLayer(image: Image("Stars1"), speed: 2).fillParent()
//        
//        ParallaxLayer(image: Image("Stars2"), speed: 7).fillParent()
//        
//        ParallaxLayer(image: Image("Stars3"), speed: 10).fillParent()
//    }
    
    @ViewBuilder
    func VerticalTabs() -> some View {
        HStack(spacing: 0) {
            VStack(spacing: 0 ) {
                TabButton(tab: .quests, selectedTab: $model.selectedTab)
                
                TabButton(tab: .characteristics, selectedTab: $model.selectedTab)
                
                #if DEBUG
                if achievementEnabledCp.value {
                    TabButton(tab: .achivements, selectedTab: $model.selectedTab)
                        .opacity(0.5)
                }
                #endif
                
                TabButton(tab: .settings, selectedTab: $model.selectedTab)
                
                Spacer()
            }
            .id(MainViewTab.quests.rawValue.localized) //fix refresh issues on locale change
            .backgroundGaussianBlur(type:.behindWindow, material: .m5_sidebar, color: Color.black.opacity(0.1))
            .animation(.easeInOut, value: achievementEnabledCp.value)
            
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
        case .quests:           return RLIcons.quest
        case .characteristics:  return RLIcons.characteristics
        case .achivements:      return RLIcons.achievementEmpty
        case .settings:         return RLIcons.settings1
        }
    }
}

public extension AuroraTheme {
    static var reLifeMain: AuroraTheme {
        AuroraTheme(bg: Color.clear,
                    ellipsesTopLeading:     Color(rgbaHex: 0xf0a04007), //Color(light: .white,  dark: Color(rgbaHex: 0xf0a04007) ),
                    ellipsesTopTrailing:    Color(rgbaHex: 0xf0a0a007), //Color(light: .blue,   dark: Color(rgbaHex: 0xf0a0a007) ),
                    ellipsesBottomTrailing: RLColors.brown.opacity(0.15), //Color(light: .green,  dark: RLColors.brown.opacity(0.15) ),
                    ellipsesBottomLeading:  RLColors.brownLight.opacity(0.15)// Color(light: .yellow, dark: RLColors.brownLight.opacity(0.15) )
        )
    }
    
    static var reLifeAchievement: AuroraTheme {
        AuroraTheme(bg: Color(nsColor: NSColor.windowBackgroundColor ),
                    ellipsesTopLeading:     RLColors.gray.opacity(0.1) , //Color(light: .white,  dark: RLColors.gray.opacity(0.1) ),
                    ellipsesTopTrailing:    RLColors.grayLight.opacity(0.1), //Color(light: .blue,   dark: RLColors.grayLight.opacity(0.1) ),
    ellipsesBottomTrailing: RLColors.brown.opacity(0.1),//Color(light: .green,  dark: RLColors.brown.opacity(0.1) ),
                    ellipsesBottomLeading:  RLColors.brownLight.opacity(0.1)//Color(light: .yellow, dark: RLColors.brownLight.opacity(0.1) )
        )
    }
}
