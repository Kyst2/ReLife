import Foundation
import SwiftUI
import MoreSwiftUI
import Essentials

struct QuestsView:View {
    @ObservedObject var model : MainViewModel
    
    @State var tab: QuestTab = .today
    
    var allQuestsIsEmpty: Bool { model.realmController.questsAll.count == 0 }
    
    var body: some View {
        if allQuestsIsEmpty {
            NoQuestsView()
        } else {
            HStack {
                TabsPanel()
                    .backgroundGaussianBlur(type: .withinWindow, material: .m2_menu)
                    .transition( .move(edge: .leading) )
                
                ContentView()
            }
        }
    }
    
    func NoQuestsView() -> some View {
        VStack(spacing: 30) {
            HStack(spacing: 0) {
                Text("key.main.quests.create-using".localized)
                    
                BtnOpenTemplatesSheet()
            }
            
            HStack(spacing: 0) {
                Text("key.main.quests.you-can-create-quest".localized)
                
                BtnOpenSettings(settingsTab: .quests)
            }
        }
        .font(.custom("SF Pro", size: 15))
    }
}

///////////////////////
///HELPERS
///////////////////////

extension QuestsView {
    func TabsPanel() -> some View {
        VStack(spacing: 0) {
            SingleTab(.today)
            SingleTab(.tomorrow)
            
            Space()
        }
    }
    
    @ViewBuilder
    func ContentView() -> some View {
        ScrollView {
            Space(18)
            
            VStack(spacing: 40) {
                switch self.tab {
                case .today:
                    TodayView()
                case .tomorrow:
                    TomorrowView()
                }
            }
            .padding(.horizontal, 10)
        }.padding(10)
    }
    
    @ViewBuilder
    func TodayView() -> some View {
        CustomSection(header: Date.now.string(withFormat: "YYYY.MM.dd"), isFinishable: true, quests: model.questToday)
        
        if model.questLongTerm.count > 0 {
            CustomSection(header: "key.main.quests.long-term".localized, isFinishable: true, quests: model.questLongTerm)
        }
    }
    
    @ViewBuilder
    func TomorrowView() -> some View {
        let tomorrow = Date.now.adding(days: 1).string(withFormat: "YYYY.MM.dd")
        
        CustomSection(header: tomorrow, isFinishable: false, quests: model.questTomorrow)
    }
}

enum QuestTab {
    case today
    case tomorrow
}

extension QuestTab {
    func asIcon() -> String {
        switch self {
        case .today:
            return RLIcons.today
        case .tomorrow:
            return RLIcons.tomorrow
        }
    }
}

extension QuestsView {
    func SingleTab(_ curr: QuestTab) -> some View {
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
                        
                        if tab == curr {
                            RoundedRectangle(cornerRadius: 0)
                                .fill(RLColors.brownLight)
                                .frame(height: 3)
                                .id("QuestTabSelection")
                                .transition(.move(edge: .leading).combined(with: .opacity))
                        }
                    }
                }
                .animation(.easeInOut(duration: 0.1), value: tab)
            }
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.3 )) {
                    tab = curr
                }
            }
    }
}




fileprivate extension QuestsView {
    @ViewBuilder
    func CustomSection(header:String, isFinishable: Bool, quests: [QuestWrapper] ) -> some View {
        VStack(alignment: .leading) {
            Text(header).titleStyle
                
            if quests.count == 0 {
                Text("Empty")
                    .frame(maxWidth: .greatestFiniteMagnitude)
                    .padding(.vertical, 10)
            } else {
                SectionBody(isFinishable: isFinishable, quests: quests)
            }
        }
    }
    
    func SectionBody(isFinishable: Bool, quests: [QuestWrapper] ) -> some View {
        VStack(spacing: 0) {
            ForEach(quests) { wrapper in
                //TODO: якщо немає опису нєфіг розгортати +++
                QuestAccordeonView(isFinishable: isFinishable, repetsCount: wrapper.finishedTimes, quest: wrapper.quest) {
                    
                    let fanfare = SheetFanfareView.init(quest: wrapper.quest)
                    GlobalDialog.shared.dialog = .view(view: AnyView(fanfare) )
                    
                    model.addToHistory(quest: wrapper.quest)
                }
            }
        }
    }
}


struct QuestAccordeonView: View {
    @State private var isExpanded = false
    @State private var hoverEffect = false
    let isFinishable: Bool
    let repetsCount: Int
    let quest:Quest
    let action:() -> Void
    
    @State var isComplete = false
    
    var isExpandable: Bool {
        !quest.descr.isEmpty
    }
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            TitleView()
            
            DecrView()
                .transition(.move(edge: .top).combined(with: .opacity))
        }
        .padding(.horizontal, 5)
        .questModifire(hoverEffect: $hoverEffect, background1: ViewBackground(), tapReaction: tapReaction)
    }
    
    @ViewBuilder
    func TitleView() -> some View {
        HStack {
            Text.sfIcon2(quest.icon.rawValue, size: 25)
                .foregroundColor( Color(nsColor: quest.colorHex.asNSColor()) )
                .font(.largeTitle)
            
            Text(quest.name)
                .myFont(size: 15)
                .foregroundColor( RLColors.brownLight )
            
            if isFinishable {
                Text("(\(repetsCount)/\(quest.repeatTimes))")
                    .myFont(size: 15)
                    .id("repeatCount_\(quest.name)_\(repetsCount)")
            }
            
            Spacer()
            
            if isExpandable {
                Button(action: {
                    withAnimation(.easeIn(duration: 0.2 )) {
                        isExpanded.toggle()}
                }) {
                    Text.sfSymbol("chevron.right")
                        .rotationEffect(isExpanded ? .degrees(-90) : .degrees(0))
                        .foregroundStyle(.black)
                        .frame(width: 25, height: 25)
                        .background {
                            expandBtnBkgrnd()
                        }
                }
                .buttonStyle(BtnUksStyle.default)
            }
        }.padding(6)
    }
    
    @ViewBuilder
    func expandBtnBkgrnd() -> some View {
        if isExpanded {
            RoundedRectangle(cornerRadius: 9)
        } else {
            Circle()
        }
    }
    
    @ViewBuilder
    func DecrView() -> some View {
        if isExpanded {
            Divider()
                .padding(.horizontal, 18)
            
            Text(quest.descr)
               .myFont(size: 14).italic()
                .padding(15)
        }
    }
    
    @ViewBuilder
    func ViewBackground() -> some View {
        ZStack {
            if quest.repeatTimes < repetsCount {
                Color.clear
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill( isComplete ? Color.gray.opacity(0.3) : Color.clear)
            }
        }
    }
    
    func tapReaction() {
        if isFinishable {
            GlobalDialog.confirmDialogYesNo(withText: "key.complete-quest?".localized, doNotCloseOnOk: true) {
                action()
            }
        }
    }
}
fileprivate extension View {
    func questModifire(hoverEffect: Binding<Bool>, background1: some View, tapReaction: @escaping () -> Void) -> some View {
        self.background{
            RoundedRectangle(cornerRadius: 8)
                .fill( hoverEffect.wrappedValue ? Color.gray.opacity(0.1) : Color.clear)
        }
        .onHover { hover in
            withAnimation(.easeOut(duration: 0.2 )) {
                hoverEffect.wrappedValue = hover
            }
        }
        .background { background1 }
        .padding(3)
        .onTapGesture(count: 2) { tapReaction() }
    }
}

fileprivate extension Text {
    var titleStyle: some View {
        self.myFont(size: 21).bold()
    }
}





/////////////////////////////
//struct QuestAccordeonView: View {
//    @ObservedObject var model : MainViewModel
//    @State private var isExpanded = false
//    @State private var hoverEffect = false
//    @State var repetsCount: Int = 0
//    
//    let isFinishable:Bool
//    let icon:String
//    let name:String
//    let repeats:Int
//    let questDescript:String
//    let action:() -> Void
//    @State var isComplete = false
//    
//    var body: some View {
//        VStack(alignment: .center){
//            TitleView()
//            
//            DecrView()
//        }
//        .questModifire(hoverEffect: $hoverEffect, background1: ViewBackground(), tapReaction: tapReaction)
//    }
//    
//    @ViewBuilder
//    func TitleView() -> some View {
//        HStack{
//            Image(systemName: icon)
//                .myImageColor()
//                .font(.largeTitle)
//            
//            Text(name)
//                .myFont(size: 15, textColor: .blue)
//
//            Text("(\(repetsCount)/\(repeats))")
//                .myFont(size: 15, textColor: .white)
//            
//            Spacer()
//            
//                Button(action: {
//                    withAnimation(.easeIn(duration: 0.2 )){
//                        isExpanded.toggle()}
//                }) {
//                    Text.sfSymbol(isExpanded ? "chevron.up" : "chevron.right")
//                        .foregroundStyle(.black)
//                        .frame(width: 25, height: 25)
//                        .background{
//                            Circle()
//                        }
//                }
//                .padding(.trailing,20)
//                .buttonStyle(BtnUksStyle.default)
//                .disableButton(questDescript: questDescript)
//            
//        }.padding(10)
//    }
//     func repeatsCount() {
//        if repeats == repetsCount {
//            model.realmController.add(history: History(quest: Quest, dateCompleted: <#T##Date#>))
//        }else {
//            self.repetsCount += 1
//        }
//    }
//    
//    @ViewBuilder
//    func DecrView() -> some View {
//        if isExpanded {
//            Text(questDescript)
//               .myFont(size: 14, textColor: .blue).italic()
//                .padding(20)
//        }
//    }
//    
//    @ViewBuilder
//    func ViewBackground() -> some View {
//        ZStack {
//            if isFinishable == false {
//                Color.clear
//            } else {
//                isComplete ? Color.gray.opacity(0.5) : Color.clear
//            }
//            
//            RoundedRectangle(cornerRadius: 0)
//                .stroke(Color.primary, lineWidth: 0.1)
//        }
//    }
//    
//    func tapReaction() {
//        if isFinishable == true {
//            if isComplete == false {
//                let sheet = AnyView(SheetConfirmationView(text: "Have you completed the quest?"){
//                    repeatsCount()
//                })
//                
//                GlobalDialog.shared.dialog = .view(view: sheet )
//                
//                isComplete = true
//            } else {
//                isComplete = false
//            }
//        }
//    }
//    
//}
//fileprivate extension View {
//    func questModifire(hoverEffect: Binding<Bool>, background1: some View, tapReaction: @escaping () -> Void) -> some View {
//        self.background( hoverEffect.wrappedValue ? Color.gray.opacity(0.1) : Color.clear )
//            .onHover{ hover in
//                withAnimation(.easeOut(duration: 0.2 )){
//                    hoverEffect.wrappedValue = hover
//                }
//            }
//            .background { background1 }
//            .padding(3)
//            .onTapGesture(count: 2) { tapReaction() }
//    }
//    @ViewBuilder
//    func disableButton(questDescript: String) -> some View {
//        if questDescript == "" {
//            self.disabled(true)
//        }else {
//            self
//        }
//    }
//}
//
//fileprivate extension Text {
//    var titleStyle: some View {
//        self
//            .myFont(size: 17, textColor: .blue).bold()
//    }
//}
///////////

/////////////////////////
///TEMP
/////////////////////////

//class Questec: ObservableObject {
//    @Published var name: String
//    @Published var icon: String
//    @Published var deteils:String
//    init(name: String, icon: String, deteils: String) {
//        self.name = name
//        self.icon = icon
//        self.deteils = deteils
//    }
//}
//
//var quests = [Questec(name: "Clean box", icon: "heart.fill" , deteils: "wash up "),Questec(name: "alarm", icon: "heart.fill", deteils: "clean room"), Questec(name: "shop", icon: "heart.fill", deteils: "buy apple")]
