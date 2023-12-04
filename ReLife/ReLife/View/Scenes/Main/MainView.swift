import SwiftUI
import MoreSwiftUI
import KystParallax

struct MainView: View {
    @ObservedObject var model = MainViewModel()
    @ObservedObject var dialogModel = GlobalDialog.shared
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            HStack(alignment: .top, spacing: 0) {
                TabsPanel()
               
                ContentPanel()
            }
        }
        .preferredColorScheme(.dark)
        .sheet(sheet: dialogModel.dialog)
    }
    
}

extension MainView {
    @ViewBuilder
    func BackgroundView() -> some View {
        RadialGradient(colors: [Color("Back"),Color("gradient3")], center: .center , startRadius: 50, endRadius: 400).offset(x: 70)
        
        ParallaxLayer(image: Image("Stars1"),speed: 2).fillParent()
        
        ParallaxLayer(image: Image("Stars2"),speed: 7).fillParent()
    }
    
    func TabsPanel() -> some View {
        ZStack(alignment: .top) {
            VisualEffectView(type:.behindWindow, material: .m5_sidebar)
                .frame(width:120)
            
            Color("blurColor")
                .opacity(0.5)
                .frame(width: 120)
            
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
        case .Quests : QuestsView()
        case .Characteristics : CharacteristicsView().fillParent()
        case .History : HistoryView().fillParent()
        case .Settings: SettingsView()
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
