import Foundation
import SwiftUI
import MoreSwiftUI

struct AchievementListView: View {
    @ObservedObject var model = AchievementListViewModel()
    
    var body: some View {
        HStack(spacing: 0) {
            TabsPanel()
                .backgroundGaussianBlur(type: .withinWindow, material: .m2_menu)
                .transition( .move(edge: .leading) )
            
            TabContent()
                .transition(AnyTransition.move(edge: .trailing))
        }
    }
}

class AchievementListViewModel: ObservableObject {
    @Published fileprivate var tab: AchievementTab = .gotten
    @Published var gotten: [Achievement] = []
    @Published var future: [Achievement] = []
    
    let allAchievements = AchievementEnum.allCases.map{ $0.asAchievement() }//.mySorted()
    
    init() {
        gotten = allAchievements.filter { $0.finished }
        future = allAchievements.filter { !$0.finished }
    }
}

/////////////////////////
///HELPERS
/////////////////////////


extension AchievementListView {
    func TabsPanel() -> some View {
        VStack(spacing: 0) {
            SingleTab(.gotten)
            SingleTab(.future)
            
            Space()
        }
    }
    
    func TabContent() -> some View {
        ScrollView {
            Space(20)
            
            LazyVStack(spacing: 20) {
                switch model.tab {
                case .gotten:
                    TabContentGotten()
                case .future:
                    TabContentFuture()
                }
            }.padding(.horizontal, 20)
            
            Space(20)
        }
    }
    
    @ViewBuilder
    func TabContentFuture() -> some View {
        if model.future.count == 0 {
            Text("key.achievment.all_gotten".localized)
                .myFont(size: 17)
                .lineSpacing(10)
                .multilineTextAlignment(.center)
                .fillParent()
        } else {
            ForEach(model.future, id: \.self) { item in
                AchievementView(model: item )
            }
        }
    }
    
    @ViewBuilder
    func TabContentGotten() -> some View {
        if model.gotten.count == 0 {
            Text("key.achievment.nothing_yet".localized)
                .myFont(size: 17)
                .multilineTextAlignment(.center)
                .fillParent()
        } else {
            ForEach(model.gotten, id: \.self) { item in
                AchievementView(model: item )
            }
        }
    }
}

fileprivate enum AchievementTab {
    case gotten
    case future
}

extension AchievementTab {
    func asIcon() -> String {
        switch self{
        case .future:
            return RLIcons.achievementEmpty
        case .gotten:
            return RLIcons.achievementFill
        }
    }
}


fileprivate extension Array where Element == Achievement {
    func mySorted() -> [Achievement] {
        self.sorted {
            if $0.type.rawValue != $1.type.rawValue {
                return $0.type.rawValue < $1.type.rawValue
            }
            
            return true
        }
    }
}

//fileprivate extension Bool {
//    var int: Int {
//        self == true ? 1 : 0
//    }
//}

fileprivate extension AchievementListView {
    func SingleTab(_ curr: AchievementTab) -> some View {
        Text.sfIcon2(curr.asIcon(), size: 25)
            .padding(12)
            .makeFullyIntaractable()
            .overlay {
                Rectangle()
                    .stroke(Color.primary, lineWidth: 0.1)
            }
            .overlay {
                VStack {
                    VStack{
                        Spacer()
                        
                        if model.tab == curr {
                            RoundedRectangle(cornerRadius: 0)
                                .fill(RLColors.brownLight)
                                .frame(height: 3)
                                .id("SettingTabSelection")
                                .transition(.move(edge: .leading).combined(with: .opacity))
                        }
                    }
                }
                .animation(.easeInOut(duration: 0.1), value: model.tab)
            }
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.3 )){
                    model.tab = curr
                }
            }
    }
}
