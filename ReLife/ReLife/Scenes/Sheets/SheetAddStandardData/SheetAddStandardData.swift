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
    Characteristic(key: StandardCharach.health.rawValue,     name: "charach.health".localized, icon: .figureMind),
    Characteristic(key: StandardCharach.tideness.rawValue,   name: "Tidiness", icon: .laurelR), //Охайність
    Characteristic(key: StandardCharach.atleticism.rawValue, name: "Athleticism", icon: .figurC),
    Characteristic(key: StandardCharach.mind.rawValue,       name: "Mind", icon: .brain)
]

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
