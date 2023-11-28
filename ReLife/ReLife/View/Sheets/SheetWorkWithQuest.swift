import SwiftUI
import MoreSwiftUI

struct SheetWorkWithQuest: View {
    let type: WorkWithTestsType
    let action: () -> Void
    
    @State var name: String = ""
    @State var deteils: String = ""
    @State var characteristics:String = ""
    @State var points:Int = 0

    let allIcons = MyIcon.allCases.map{ $0.rawValue }
    
    @State private var icon: String = MyIcon.batteryFull.rawValue
    
    var body: some View {
        ScrollView{
            VStack {
                Title()
                
                SheetContent()
                
                Buttons()
            }
        }
        .backgroundGaussianBlur(type: .behindWindow , material: .m1_hudWindow)
        .frame(minWidth: 500,minHeight: 200)
        
    }
}

extension SheetWorkWithQuest {
    func Title() -> some View {
        Text(type.asTitle())
            .myFont(size: 17, textColor: .blue)
            .padding()
    }
    
    @ViewBuilder
    func SheetContent() -> some View {
        Text("Pick icon")
            .applyTextStyle()
        
        IconPicker()

        Text("Enter \(type.asEnterName()) name")
            .applyTextStyle()
        
        TextField("WriteName", text: $name)
            .applyFieldStyle()
        
        if type == .questCreator || type == .questEditor {
            CharacteristicsList()
        }
        if type == .questCreator || type == .questEditor {
            Text("Enter \(type.asEnterName()) deteils")
                .applyTextStyle()
            
            TextEditor(text: $deteils)
                .frame(minHeight: 60)
                .cornerRadius(10)
                .padding(10)
                .font(.custom("MontserratRoman-Regular", size: 13)).italic()
                .foregroundColor(Color("textColor"))
        }
    }
    
    func IconPicker() -> some View {
            Picker("", selection: $icon) {
                ForEach(allIcons, id: \.self ) { image in
                    Text.sfIcon(image, size: 15)
                }
            }.frame(width: 70)
    }
    
    func CharacteristicsList() -> some View {
            ForEach(char, id: \.self) { char in
                CharacteristicsAndPointList(name: char.name)
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
struct MyButton: View {
    let label: String
    
    let txtColor: Color // Color("iconColor") .black
    let bgColor: Color // Color("blurColor").opacity(0.8)   .primary
    
    let action: () -> Void
    
    var body: some View{
        Button(action: action) {
            buttonUI()
        }
        .buttonStyle(.plain)
        .frame(width: 100, height: 40)
        .frame(maxWidth: .infinity)
    }
    
    func buttonUI() -> some View {
        HStack{
            Text(label)
                .foregroundColor(txtColor)
                .font(.custom("MontserratRoman-Regular", size: 17))
        }
        .background{
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(bgColor)
                .frame(width: 70,height: 35)
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
            .foregroundColor(Color("textColor"))
            .font(.custom("MontserratRoman-Regular", size: 15))
            .padding()
    }
}


enum WorkWithTestsType{
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
