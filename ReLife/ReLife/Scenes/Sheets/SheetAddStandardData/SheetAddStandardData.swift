import Foundation
import SwiftUI
import MoreSwiftUI
import AppCoreLight

struct SheetAddStandardData: View {
    @State private var charachModels = characs.map{ ToggleModel($0) }
    @State private var questModels   = StandardQuests.allCases.map { ToggleModel($0) }
    
    var body: some View {
        VStack {
            Text("You able to add default data to your app. \nPlease, choose what do you need")
                .multilineTextAlignment(.center)
                .lineLimit(10)
                .fixedSize(horizontal: true, vertical: false)
                .foregroundColor(.orange)
            
            ScrollView{
                HStack {
                    VStack(alignment: .leading) {
                        Text("key.characteristics".localized)
                            .font(.title)
                            .centredHoriz()
                         
                        CharachCheckboxes()
                        
                        Text("key.quests".localized)
                            .font(.title)
                            .centredHoriz()
                        
                        QuestsCheckboxes()
                    }
                    
                    Space()
                }
            }
            .frame(minWidth: 400, idealWidth: 400, minHeight: 300, idealHeight: 300)
            
            HStack(spacing: 40) {
                CircleButton(icon: RLIcons.back, iconSize: 21, iconColor: NSColor.red.color, action: funcCancel)
                
                CircleButton(icon: RLIcons.ok, iconSize: 19, iconColor: .green, action: funcOk)
            }
        }
        .padding(20)
    }
    
    func funcCancel() {
        GlobalDialog.shared.dialog = .none
    }
    
    func funcOk() {
        charachModels
            .filter { $0.checked }
            .map { $0.item }
            .forEach { RealmController.shared.add(characteristic: $0) }
        
        let addedCharacs = RealmController.shared.characteristicsAll
        
        questModels
            .filter { $0.checked }
            .map { $0.item }
            .forEach{ RealmController.shared.add(quest: $0.asQuest(characteristics: addedCharacs) )}
        
        AppCore.signals.send(signal: RLSignal.ReloadData())
        
        GlobalDialog.shared.dialog = .none
    }
}

//////////////////////////
// DATA
/////////////////////////

let characs: [Characteristic] = [
    Characteristic(key: "health",      name: "charach.health".localized, icon: "figure.mind.and.body"),
    Characteristic(key: "tidness",     name: "Tidiness", icon: "laurel.trailing"), //Охайність
    Characteristic(key: "athleticism", name: "Athleticism", icon: "figure.cooldown"),
    Characteristic(key: "mind",        name: "Mind", icon: "brain")
]

//let quests: [String] = [
//    "Clean teeth",
//    "Dantist visit",
//    "Clean my apartment",
//    "Learn Swift programming language",
//    "Play/Learn Guitar",
//    "Push-ups",
//    "Visit to a gynecologist",
//    "Visit to a gynecologist for a detailed examination",
//    "Drink a water",
//    "Wash my hair"
//]
//let q: [Quest] = [
//    Quest(name: "Clean teeth", icon: .forkKnife, color: .clear, charachPoints: [RealmController.shared.characteristicsAll.first? :15], questRepeatStr: .repeatEvery(days: 1, startingFrom: Date.now), repeatTimes: 2, descript: ""),
//    Quest(name: "Dantist visit", icon: .tray, color: .clear, charachPoints: [RealmController.shared.characteristicsAll.first!:15], questRepeatStr: .repeatEvery(days: 1, startingFrom: Date.now), repeatTimes: 2, descript: ""),
//    Quest(name: "Clean my apartment", icon: .crossCase, color: .clear, charachPoints: [RealmController.shared.characteristicsAll.first!:15], questRepeatStr: .repeatEvery(days: 1, startingFrom: Date.now), repeatTimes: 2, descript: ""),
//    Quest(name: "Learn Swift programming language", icon: .playstation, color: .clear, charachPoints: [RealmController.shared.characteristicsAll.first!:15], questRepeatStr: .repeatEvery(days: 1, startingFrom: Date.now), repeatTimes: 2, descript: ""),
//    Quest(name: "Play/Learn Guitar", icon: .americanFootball, color: .clear, charachPoints: [RealmController.shared.characteristicsAll.first!:15], questRepeatStr: .repeatEvery(days: 1, startingFrom: Date.now), repeatTimes: 2, descript: ""),
//    Quest(name: "Push-ups", icon: .bolt, color: .clear, charachPoints: [RealmController.shared.characteristicsAll.first!:15], questRepeatStr: .repeatEvery(days: 1, startingFrom: Date.now), repeatTimes: 2, descript: ""),
//    Quest(name: "Visit to a gynecologist", icon: .charBook, color: .clear, charachPoints: [RealmController.shared.characteristicsAll.first!:15], questRepeatStr: .repeatEvery(days: 1, startingFrom: Date.now), repeatTimes: 2, descript: ""),
//    Quest(name: "Visit to a gynecologist for a detailed examination", icon: .geraShape, color: .clear, charachPoints: [RealmController.shared.characteristicsAll.first!:15], questRepeatStr: .repeatEvery(days: 1, startingFrom: Date.now), repeatTimes: 2, descript: ""),
//    Quest(name: "Drink a water", icon: .beachUmbrella, color: .clear, charachPoints: [RealmController.shared.characteristicsAll.first!:15], questRepeatStr: .repeatEvery(days: 1, startingFrom: Date.now), repeatTimes: 2, descript: ""),
//    Quest(name: "Wash my hair", icon: .partyPopper, color: .clear, charachPoints: [RealmController.shared.characteristicsAll.first!:15], questRepeatStr: .repeatEvery(days: 1, startingFrom: Date.now), repeatTimes: 2, descript: "")
//]

/////////////////////////////
///HELPERS
////////////////////////////

extension SheetAddStandardData {
    func CharachCheckboxes() -> some View {
        ForEach(charachModels.indices) { idx in
            HStack {
                Toggle("", isOn: .constant(self.charachModels[idx].checked))
                
                Text(self.charachModels[idx].item.name)
            }
            .overlay(Color.clickableAlpha)
            .onTapGesture { self.charachModels[idx].checked.toggle() }
        }
    }
    
    func QuestsCheckboxes() -> some View {
        ForEach(questModels.indices) { idx in
            HStack {
                Toggle("", isOn: .constant(self.questModels[idx].checked))
                
                Text(self.questModels[idx].item.title)
            }
            .overlay(Color.clickableAlpha)
            .onTapGesture { self.questModels[idx].checked.toggle() }
        }
    }
}
