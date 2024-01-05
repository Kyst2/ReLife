import Foundation
import SwiftUI
import MoreSwiftUI
import Realm

struct SheetQuestEditorView: View {
    @ObservedObject var model: SettingsViewModel
    let type: WorkWithTestsType
    let action: () -> Void
    
    @State var name: String
    @State var deteils: String
    @State var characsAndPoints: [CharacteristicsAndPoints]
    @State var questColor: UInt32 = 0x204729
    
    @State private var icon: String = QuestIcon.batteryFull.rawValue
    
    init(model: SettingsViewModel, type: WorkWithTestsType, quest: Quest?, action: @escaping () -> Void) {
        self.model = model
        self.type = type
        self.name = quest?.name ?? ""
        self.deteils = quest?.descript ?? ""
        
        if let quest {
            self.icon = type == .questEditor ? quest.icon.rawValue : QuestIcon.batteryFull.rawValue
        } else {
            self.icon = QuestIcon.batteryFull.rawValue
        }
        self.action = action
        
        self.characsAndPoints = model.allCharacteristics.map {
            let questPoints = quest?.charachPoints[$0.key] ?? 0
            
            return CharacteristicsAndPoints(charac: $0, points: questPoints)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Title()
                
                SheetContent()
                
                Buttons()
            }
        }
        .padding(20)
        .backgroundGaussianBlur(type: .behindWindow , material: .m1_hudWindow)
        .frame(minWidth: 500,minHeight: 200)
        
    }
}

extension SheetQuestEditorView {
    func Title() -> some View {
        Text(type.asTitle())
            .myFont(size: 17)
            .padding()
    }
    
    var titleWidth: CGFloat { 50 }
    
    @ViewBuilder
    func SheetContent() -> some View {
        VStack(spacing: 7) {
            HStack {
                Text("Title:")
                    .frame(width: titleWidth)
                
                TextField("Don't let me empty!", text: $name)
                    .applyFieldStyle()
                    .foregroundColor(Color(hex: questColor))
                
                IconPicker(icon: $icon)
                    .foregroundColor(Color(hex: questColor))
                
                ColorPicker(color: $questColor)
                    .frame(width: 20, height: 20)
                //заміни на власний пікер аналогічний ікон пікера з тим набором кольорів який я просив
//                UksColorPicker(color: $questColor)
//                    .frame(width: 20, height: 20)
            }
            
            if type == .questCreator || type == .questEditor {
                HStack {
                    Text("Descr:")
                        .frame(width: titleWidth)
                    
                    TextEditor(text: $deteils)
                        .frame(minHeight: 60)
                        .cornerRadius(10)
                        .font(.custom("MontserratRoman-Regular", size: 13)).italic()
                        .foregroundColor(Color("textColor"))
                }
            }
            
            QuestRepeatTypeView()
            
            if type == .questCreator || type == .questEditor {
                CharacteristicsAndPointsListView(charAndPoints: $characsAndPoints)
            }
        }
    }
    
    func Buttons() -> some View {
        HStack {
            MyButton(label: type.asBtnText(), txtColor: Color("iconColor"), bgColor: Color("blurColor").opacity(0.8)) {
                action()
                GlobalDialog.shared.dialog = .none
            }
            
            MyButton(label: "Cancel", txtColor: .black, bgColor: .primary) {
                GlobalDialog.shared.dialog = .none
            }
        }
    }
}

////////////////
///HELPERS
////////////////
fileprivate struct CharacteristicsAndPointList: View {
    let name: String
    @State var points = 0
    var body: some View {
        HStack {
            Text(name)
                .lineLimit(2)
            TextField("Enter an integer", value: $points, formatter: NumberFormatter())
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
            CharacteristicsAndPointsListButton()
        }
    }
}

fileprivate struct CharacteristicsAndPointsListButton: View {
    @State var isCharacteristic: Bool = false
    var body: some View {
        Button {
            
            isCharacteristic.toggle()
        } label: {
            Image(systemName: "checkmark")
                .foregroundColor(isCharacteristic ? .gray : .black)
        }
    }
}

enum WorkWithTestsType {
    case questCreator
    case questEditor
    case characteristicCreator
    case characteristicEdit
}

extension WorkWithTestsType {
    func asTitle() -> String {
        switch self {
        case .questCreator:
            return "Quest Creator"
        case .questEditor:
            return "Quest edit"
        case .characteristicCreator:
            return "Characteristic Creator"
        case .characteristicEdit :
            return "Characteristic Edit"
        }
    }
    
    func asBtnText() -> String {
        switch self {
        case .questCreator:
            return "Create"
        case .questEditor:
            return "Save"
        case .characteristicCreator:
            return "Creator"
        case .characteristicEdit :
            return "Save"
        }
    }
    func asEnterName() -> String {
        switch self {
        case .questCreator:
            return "quest"
        case .questEditor:
            return "quest"
        case .characteristicCreator:
            return "characteristic"
        case .characteristicEdit :
            return "сharacteristic"
        }
    }
}


fileprivate extension Text {
    func applyTextStyle() -> some View {
        self
            .foregroundColor(Color("textColor"))
            .font(.custom("MontserratRoman-Regular", size: 13)).italic()
    }
}

fileprivate extension TextField {
    func applyFieldStyle() -> some View {
        self
            .textFieldStyle(.roundedBorder)
            .font(.custom("MontserratRoman-Regular", size: 15))
    }
}







//move to another place!


//struct ChevronUpDown: View {
//    var body: some View {
//        Text.sfSymbol("chevron.up.chevron.down")
//            .foregroundColor(.black)
//            .background( RoundedRectangle(cornerRadius: 3).padding(.horizontal, -4) )
//    }
//}





