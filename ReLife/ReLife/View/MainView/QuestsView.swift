import Foundation
import SwiftUI
import MoreSwiftUI

struct QuestsView:View {
    var body: some View {
        ScrollView {
            Space(18)
            
            VStack(spacing: 15) {
                CustomSection(header: "Today's Quests", isFinishable: true)
             
                CustomSection(header: "Tomorrow's Quests", isFinishable: false)
                
                CustomSection(header: "Long-term Quests", isFinishable: false)
            }
        }
    }
}

///////////////////////
///HELPERS
///////////////////////

fileprivate extension QuestsView {
    func CustomSection(header:String, isFinishable: Bool) -> some View {
        Section(header: Text(header).titleStyle ) {
            SectionBody(isFinishable: isFinishable)
        }
    }
    
    func SectionBody(isFinishable: Bool) -> some View {
        ForEach(quests.indices, id: \.self) { index in
            let quest = quests[index]
            
            if isFinishable {
                AccordeonView(questToday: true, icon: quest.icon, name: quest.name) {
                    Text(quest.deteils)
                        .myColorBlue()
                        .myFont(size: 14).italic()
                }
            } else {
                AccordeonView(questToday: false, icon: quest.icon, name: quest.name) {
                    Text(quest.deteils)
                        .myColorBlue()
                        .myFont(size: 14).italic()
                }
            }
        }
    }
}

/// привести в порядок
struct AccordeonView<Content: View>: View {
    @State private var isExpanded = false
    @State private var hoverEffect = false
    
    let questToday:Bool
    let icon:String
    let name:String
    let content: () -> Content
    @State var isComplete = false
    
    var body: some View {
        VStack {
            TitleView()
            
            DecrView()
        }
        .padding(10)
        .background( hoverEffect ? Color.gray.opacity(0.5) : Color.clear )
        .onHover{ hover in
            withAnimation(.easeOut(duration: 0.2 )){
                self.hoverEffect = hover
            }
        }
        .background { ViewBackground() }
        .onTapGesture(count: 2) { tapReaction() }
    }
    @ViewBuilder
    func TitleView() -> some View {
        HStack{
            Image(systemName: icon)
                .myImageColor()
                .font(.largeTitle)
            
            Text(name)
                .myColorBlue()
                .myFont(size: 15)

            
            Spacer()
            
            Button(action: {
                withAnimation(.easeIn(duration: 0.2 )){
                    isExpanded.toggle()}
            }) {
                Text.sfSymbol(isExpanded ? "chevron.up" : "chevron.right")
            }
            .padding(.trailing,20)
            .buttonStyle(.plain)
        }
    }
    
    @ViewBuilder
    func DecrView() -> some View {
        if isExpanded {
            content()
                .padding()
        }
    }
    
    @ViewBuilder
    func ViewBackground() -> some View {
        ZStack {
            if questToday == false {
                Color.clear
            } else {
                isComplete ? Color.gray.opacity(0.5) : Color.clear
            }
            
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.primary, lineWidth: 0.1)
        }
    }
    
    func tapReaction() {
        if questToday == true {
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


fileprivate extension Text {
    var titleStyle: some View {
        self
            .myFont(size: 17).bold()
            .myColorBlue()
    }
}

/////////////////////////
///TEMP
/////////////////////////

class Questec: ObservableObject {
    @Published var name: String
    @Published var icon: String
    @Published var deteils:String
    init(name: String, icon: String, deteils: String) {
        self.name = name
        self.icon = icon
        self.deteils = deteils
    }
}

var quests = [Questec(name: "Clean box", icon: "heart.fill" , deteils: "wash up "),Questec(name: "alarm", icon: "heart.fill", deteils: "clean room"), Questec(name: "shop", icon: "heart.fill", deteils: "buy apple")]
