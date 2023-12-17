import SwiftUI
import MoreSwiftUI
import KystParallax

struct MainView: View {
    @ObservedObject var model = MainViewModel()
    @ObservedObject var dialogModel = GlobalDialog.shared
    
    var body: some View {
        ZStack {
            BackgroundView()
                .opacity(0.3)
            
            HStack(alignment: .top, spacing: 0) {
                TabsPanel()
               
                //TODO: Fix UI in case of all quests are empty +++
                ContentPanel()
                    .frame(minWidth: 600)
            }
        }
        .preferredColorScheme(.dark)
        .sheet(sheet: dialogModel.dialog)
    }
}

extension MainView {
    @ViewBuilder
    func BackgroundView() -> some View {
        ParallaxLayer(image: Image("Stars1"),speed: 2).fillParent()
        
        ParallaxLayer(image: Image("Stars2"),speed: 7).fillParent()
        
        ParallaxLayer(image: Image("Stars3"),speed: 10).fillParent()
    }
    
    func TabsPanel() -> some View {
        ZStack(alignment: .top) {
            VisualEffectView(type:.behindWindow, material: .m1_hudWindow)
                .frame(width:120)
                .overlay { Color("blurColor").opacity(0.1) }
            
            VStack(spacing: 0 ){
                TabButton(tab: .Quests, selectedTab: $model.selectedTab)
                TabButton(tab: .Characteristics, selectedTab: $model.selectedTab)
                TabButton(tab: .History, selectedTab: $model.selectedTab)
                TabButton(tab: .Settings, selectedTab: $model.selectedTab)
            }
        }
    }
    
    @ViewBuilder
    func ContentPanel() -> some View {
        switch(model.selectedTab){
        case .Quests : 
            QuestsView(model: model)
                .fillParent()
        case .Characteristics :
            CharacteristicsView(model: model)
                .fillParent()
        case .History :
            HistoryView().fillParent()
        case .Settings: 
            SettingsView()
                .fillParent()
        }
    }
}

///////////////////////
///HELPERS
//////////////////////

enum MainViewTab: String {
    case Quests
    case Characteristics
    case History
    case Settings
}

extension MainViewTab {
    var title: String {
        self.rawValue
    }
    
    var icon: String {
        switch self {
        case .Quests:           return "list.bullet.clipboard"
        case .Characteristics:  return "medal"
        case .History:          return "book"
        case .Settings:         return "gearshape"
        }
    }
}
