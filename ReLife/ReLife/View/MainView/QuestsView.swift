import Foundation
import SwiftUI
import MoreSwiftUI

struct QuestsView:View {
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Space(3)
                CustomSection(header: "Today's Quests", isFinishable: true)
             
                CustomSection(header: "Tomorrow's Quests", isFinishable: false)
                
                CustomSection(header: "Long-term Quests", isFinishable: false)
            }
        }
    }
}

struct AccordeonView<Content: View>: View {
    @State private var isExpanded = false
    @State private var hoverEffect = false
    @State private var dialog: SheetDialogType = .none
    
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
        .sheet(sheet: dialog)
        .onTapGesture(count: 2) { tapReaction() }
    }
    
    func TitleView() -> some View {
        HStack{
            Image(systemName: icon)
                .foregroundColor(Color("iconColor"))
                .font(.largeTitle)
            
            Text(name)
                .foregroundColor(Color("textColor"))
                .font(.custom("MontserratRoman-Regular", size: 15))
            
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
                let sheet = AnyView(SheetConfirmationView(dialog: $dialog))
                
                dialog = .view(view: sheet )
                
                isComplete = true
            } else {
                isComplete = false
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
                        .font(.custom("MontserratRoman-Regular", size: 14).italic())
                        .foregroundColor(Color("textColor"))
                }
            } else {
                AccordeonView(questToday: false, icon: quest.icon, name: quest.name) {
                    Text(quest.deteils)
                        .font(.custom("MontserratRoman-Regular", size: 14).italic())
                        .foregroundColor(Color("textColor"))
                }
            }
        }
    }
}


fileprivate extension Text {
    var titleStyle: some View {
        self.font(.custom("MontserratRoman-Regular", size: 17).bold())
            .foregroundColor(Color("textColor"))
    }
}

/////////////////////////
///TEMP
/////////////////////////

class Questec {
    var name: String
    var icon: String
    var deteils:String
    init(name: String, icon: String, deteils: String) {
        self.name = name
        self.icon = icon
        self.deteils = deteils
    }
}

var quests = [Questec(name: "Quest1", icon: "heart.fill" , deteils: "wash up "),Questec(name: "Quest2", icon: "heart.fill", deteils: "clean room"), Questec(name: "Quest3", icon: "heart.fill", deteils: "buy apple")]
