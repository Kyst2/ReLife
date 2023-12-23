import Foundation
import SwiftUI
import MoreSwiftUI

struct SheetAddStandardData: View {
    @State private var charachModels = characs.map{ CharachToggleModel($0) }
    @State private var questModels = quests.map{ QuestToggleModel($0) }
    
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
                        Text("Characteristics")
                            .font(.title)
                            .centredHoriz()
                         
                        CharachCheckboxes()
                        
                        Text("Quests")
                            .font(.title)
                            .centredHoriz()
                        
                        QuestsCheckboxes()
                    }
                    
                    Space()
                }
            }
            .frame(minWidth: 400, idealWidth: 400, minHeight: 300, idealHeight: 300)
            
            HStack(spacing: 40) {
                Button(action: funcCancel ) {
                    Text.sfIcon2("arrowshape.turn.up.left", size: 30)
                        .foregroundColor(.red)
                }
                .buttonStyle(BtnUksStyle.default)
                
                Button(action: funcOk ) {
                    Text.sfIcon2("checkmark", size: 30)
                        .foregroundColor(.green)
                }
                .buttonStyle(BtnUksStyle.default)
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
        
        GlobalDialog.shared.dialog = .none
    }
}

//////////////////////////
// DATA
/////////////////////////

let characs: [Characteristic] = [
    Characteristic(name: "Health", icon: "figure.mind.and.body"),
    Characteristic(name: "Tidiness", icon: "laurel.trailing"), //Охайність
    Characteristic(name: "Athleticism", icon: "figure.cooldown"),
    Characteristic(name: "Mind", icon: "brain")
]

let quests: [String] = [
    "Clean teeth",
    "Dantist visit",
    "Clean my apartment",
    "Learn Swift programming language",
    "Play/Learn Guitar",
    "Push-ups",
    "Visit to a gynecologist",
    "Visit to a gynecologist for a detailed examination",
    "Drink a water",
    "Wash my hair"
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
                
                Text(self.questModels[idx].item)
            }
            .overlay(Color.clickableAlpha)
            .onTapGesture { self.questModels[idx].checked.toggle() }
        }
    }
}

fileprivate struct CharachToggleModel {
    let item: Characteristic
    var checked: Bool = true
    
    init(_ item: Characteristic) {
        self.item = item
    }
}

fileprivate struct QuestToggleModel {
    let item: String
    var checked: Bool = true
    
    init(_ item: String) {
        self.item = item
    }
}
