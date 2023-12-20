import SwiftUI
import MoreSwiftUI
import KystParallax

struct MainView: View {
    @ObservedObject var model = MainViewModel()
    @ObservedObject var dialogModel = GlobalDialog.shared
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VerticalTabs()
            
            ContentPanel()
                .fillParent()
                .frame(minWidth: 600)
        }
        .background( BackgroundView().opacity(0.3) )
        .preferredColorScheme(.dark)
        .sheet(sheet: dialogModel.dialog)
    }
}

extension MainView {
    @ViewBuilder
    func BackgroundView() -> some View {
        ParallaxLayer(image: Image("Stars1"), speed: 2).fillParent()
        
        ParallaxLayer(image: Image("Stars2"), speed: 7).fillParent()
        
        ParallaxLayer(image: Image("Stars3"), speed: 10).fillParent()
    }
    
    func VerticalTabs() -> some View {
        HStack(spacing: 0) {
            VStack(spacing: 0 ) {
                TabButton(tab: .quests, selectedTab: $model.selectedTab)
                TabButton(tab: .characteristics, selectedTab: $model.selectedTab)
                TabButton(tab: .history, selectedTab: $model.selectedTab)
                TabButton(tab: .settings, selectedTab: $model.selectedTab)
                
                Spacer()
            }
            .backgroundGaussianBlur(type:.behindWindow, material: .m5_sidebar, color: Color.black.opacity(0.1))
            .frame(width:120)
            
            Divider()
        }
    }
    
    @ViewBuilder
    func ContentPanel() -> some View {
        switch(model.selectedTab){
        case .quests : 
            QuestsView(model: model)
        case .characteristics :
            CharacteristicsView(model: model)
        case .history :
            HistoryView()
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
    case history = "key.history"
    case settings = "Settings"
}

extension MainViewTab {
    var title: String {
        self.rawValue.localized
    }
    
    var icon: String {
        switch self {
        case .quests:           return "list.bullet.clipboard"
        case .characteristics:  return "medal"
        case .history:          return "book"
        case .settings:         return "gearshape"
        }
    }
}
