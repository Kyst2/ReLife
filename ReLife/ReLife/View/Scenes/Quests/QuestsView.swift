import Foundation
import SwiftUI
import MoreSwiftUI

struct QuestsView:View {
    @ObservedObject var model : MainViewModel
    
    
    var body: some View {
        ScrollView {
            Space(18)
            
            VStack(spacing: 15) {
                CustomSection(header: "Today's Quests", isFinishable: true, quests: model.questToday)
             
                CustomSection(header: "Tomorrow's Quests", isFinishable: false, quests: model.questTomorrow)
                
                CustomSection(header: "Long-term Quests", isFinishable: true, quests: model.questLongTerm)
            }
        }.padding(10)
    }
}

///////////////////////
///HELPERS
///////////////////////

fileprivate extension QuestsView {
    func CustomSection(header:String, isFinishable: Bool, quests: [Quest] ) -> some View {
        Section(header: Text(header).titleStyle ) {
            SectionBody(isFinishable: isFinishable, quests: quests)
        }
    }
    
    func SectionBody(isFinishable: Bool, quests: [Quest] ) -> some View {
        ForEach(quests.indices, id: \.self) { index in
            let quest = quests[index]
            
            QuestAccordeonView(isFinishable: isFinishable, icon: quest.icon.rawValue , name: quest.name) {
                Text(quest.descript)
                   .myFont(size: 14, textColor: .blue).italic()
            }
        }
    }
}

/// привести в порядок
struct QuestAccordeonView<Content: View>: View {
    @State private var isExpanded = false
    @State private var hoverEffect = false
    
    let isFinishable:Bool
    let icon:String
    let name:String
    let content: () -> Content
    @State var isComplete = false
    
    var body: some View {
        VStack(alignment: .center){
            TitleView()
            
            DecrView()
        }
        .questModifire(hoverEffect: $hoverEffect, background1: ViewBackground(), tapReaction: tapReaction)
    }
    
    @ViewBuilder
    func TitleView() -> some View {
        HStack{
            Image(systemName: icon)
                .myImageColor()
                .font(.largeTitle)
            
            Text(name)
                .myFont(size: 15, textColor: .blue)

            
            Spacer()
            
            Button(action: {
                withAnimation(.easeIn(duration: 0.2 )){
                    isExpanded.toggle()}
            }) {
                Text.sfSymbol(isExpanded ? "chevron.up" : "chevron.right")
            }
            .padding(.trailing,20)
            .buttonStyle(.plain)
        }.padding(10)
    }
    
    @ViewBuilder
    func DecrView() -> some View {
        if isExpanded {
            content()
                .padding(20)
        }
    }
    
    @ViewBuilder
    func ViewBackground() -> some View {
        ZStack {
            if isFinishable == false {
                Color.clear
            } else {
                isComplete ? Color.gray.opacity(0.5) : Color.clear
            }
            
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.primary, lineWidth: 0.1)
        }
    }
    
    func tapReaction() {
        if isFinishable == true {
            if isComplete == false {
                let sheet = AnyView(SheetConfirmationView(text: "Have you completed the quest?"){
                    
                })
                
                GlobalDialog.shared.dialog = .view(view: sheet )
                
                isComplete = true
            } else {
                isComplete = false
            }
        }
    }
}
fileprivate extension View {
    func questModifire(hoverEffect: Binding<Bool>, background1: some View, tapReaction: @escaping () -> Void) -> some View {
        self.background( hoverEffect.wrappedValue ? Color.gray.opacity(0.5) : Color.clear )
            .onHover{ hover in
                withAnimation(.easeOut(duration: 0.2 )){
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
        self
            .myFont(size: 17, textColor: .blue).bold()
    }
}


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
