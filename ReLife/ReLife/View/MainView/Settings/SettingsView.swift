import Foundation
import SwiftUI
import MoreSwiftUI

fileprivate enum SettingsTab: String {
    case General
    case Quest
    case Characteristics
}

struct SettingsView: View {
    @State fileprivate var tab: SettingsTab = .General
    
    @State private var dialog: SheetDialogType = .none
    
    var body: some View {
        VStack(spacing: 15){
            TabsPanel()
            
            TabsBody()
        }
    }
//    func tapReaction() {
//
//        let sheet = AnyView(QuestsEditSheet(quest: sel, dialog: $dialog))
//
//        dialog = .view(view: sheet )
//
//    }
    
    func TabsPanel() -> some View {
        HStack(spacing: 0) {
            ConfigTabView(tab: $tab, curr: .General)
            
            ConfigTabView(tab: $tab, curr: .Quest)
            
            ConfigTabView(tab: $tab, curr: .Characteristics)
        }
    }
    
    @ViewBuilder
    func TabsBody() -> some View {
        switch tab {
        case .General:
            ConfigGeneralView()
        case .Quest:
            ConfigQuestView()
        case .Characteristics:
            ConfigCharacteristicsView()
        }
    }
}

struct ConfigGeneralView: View {
    var body: some View {
        Text("General")
            .fillParent()
    }
}

struct ConfigQuestView: View {
    var body: some View {
        Text("Quests")
            .fillParent()
    }
}

struct ConfigCharacteristicsView: View {
    var body: some View {
        Text("Characteristics")
            .fillParent()
    }
}

struct ConfigTabView: View {
    @Binding fileprivate var tab: SettingsTab
    fileprivate let curr: SettingsTab
    
    var body: some View {
        MenuButtons(lebel: curr.rawValue ) {
            tab = curr
        }.background{
            tab == curr ? Color.gray.opacity(0.5) : Color.clear
        }
    }
}

extension SettingsView {

    
    
//    @ViewBuilder
//    func QuestsSettings() -> some View {
//        ScrollView{
//            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
//                if isQuest {
//                    bodyScrollQuests()
//                } else {
//                    bodyScrollCharacteristics()
//                }
//            }
//        }
//    }
//
//    func AddQuestOrCharacteristics() -> some View {
//        HStack(alignment: .top){
//            Spacer()
//            if isQuest == true {
//                AddButton(lebel: "Quest") {
//
//                }
//            }else {
//                AddButton(lebel: "Characteristic") {
//
//                }
//            }
//            Space(10)
//        }
//    }
}






/////////////////
///HELPERS
/////////////////
fileprivate extension SettingsView {
    func bodyScrollQuests() -> some View {
        ForEach(quests.indices, id: \.self) { index in
            let quest = quests[index]
            QuestSettingView(name: quest.name, icon: quest.icon , deteils: quest.deteils)
        }
    }
    func bodyScrollCharacteristics() -> some View {
        ForEach(char.indices, id: \.self) { index in
            let char = char[index]
            CharactSettingView(name: char.name, icon: char.icon, points: char.points)
        }
    }
}


struct CharactSettingView : View {
    @State private var hoverEffect = false
    
    @State var name: String
    @State var icon: String
    @State var points: Int
    var body: some View {
        HStack{
            Space(5)
            Image(systemName: icon)
                .foregroundColor(Color("iconColor"))
                .font(.largeTitle)
            
            Text(name)
                .foregroundColor(Color("textColor"))
                .font(.custom("MontserratRoman-Regular", size: 15))
            Spacer()
        }.padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
            .background( hoverEffect ? Color.gray.opacity(0.5) : Color.clear )
            .onHover{ hover in
                withAnimation(.easeOut(duration: 0.2 )){
                    self.hoverEffect = hover
                }
            }
            .onTapGesture(count: 2) {
                
                ///open settings view for element
            }
    }
}

struct QuestSettingView: View {
    @State private var hoverEffect = false
    
    @State var name: String
    @State var icon: String
    @State var deteils: String
    var body: some View {
        HStack{
            Space(5)
            Image(systemName: icon)
                .foregroundColor(Color("iconColor"))
                .font(.largeTitle)
            
            Text(name)
                .foregroundColor(Color("textColor"))
                .font(.custom("MontserratRoman-Regular", size: 15))
            Spacer()
        }.padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
            .background( hoverEffect ? Color.gray.opacity(0.5) : Color.clear )
            .onHover{ hover in
                withAnimation(.easeOut(duration: 0.2 )){
                    self.hoverEffect = hover
                }
            }
            .onTapGesture(count: 2) {
                
                ///open settings view for element
            }
    }
}

struct AddButton: View {
    let lebel: String
    let action: () -> Void
    var body: some View{
        Button {
            action()
        } label: {
            HStack{
                Image(systemName: "plus")
                    .foregroundColor(Color("iconColor"))
                    .font(.largeTitle)
                
                Text(lebel)
                    .foregroundColor(Color("textColor"))
                    .font(.custom("MontserratRoman-Regular", size: 20))
                
            }
        }
        .buttonStyle(.plain)
        .frame(width: 400,height: 40)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color("blurColor")).opacity(0.8)
        }
        .padding(20)
        .fixedSize()
        .frame(maxWidth: .infinity)
        
    }
}

struct MenuButtons: View {
    let lebel: String
    let action: () -> Void
    var body: some View {
        Button {
            withAnimation(.easeIn(duration: 0.2 )){
                action()
            }
        } label: {
            Text(lebel)
                .foregroundColor(Color("textColor"))
                .font(.custom("MontserratRoman-Regular", size: 18))
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.primary, lineWidth: 0.1)
        }
    }
}
