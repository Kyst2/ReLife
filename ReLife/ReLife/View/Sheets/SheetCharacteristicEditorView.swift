import SwiftUI
import MoreSwiftUI

struct SheetCharacteristicEditorView: View {
    @ObservedObject var model: SettingsViewModel
    let type: WorkWithTestsType
    let action: () -> Void
    
    @State var name: String
    @State var deteils: String
//    @State var characteristics:String = ""
//    @State var points:Int = 0
    
    let allIcons = MyIcon.allCases.map{ $0.rawValue }
    
    @State private var icon: String = MyIcon.batteryFull.rawValue
    
    init(model: SettingsViewModel, type: WorkWithTestsType, quest: Quest?, action: @escaping () -> Void) {
        self.model = model
        self.type = type
        self.name = quest?.name ?? ""
        self.deteils = quest?.description ?? ""
        
        if let quest {
            self.icon = type == .questEditor ? quest.icon.rawValue : MyIcon.batteryFull.rawValue
        } else {
            self.icon = MyIcon.batteryFull.rawValue
        }
        
        
        self.action = action
    }
    
    var body: some View {
        ScrollView{
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

extension SheetCharacteristicEditorView {
    func Title() -> some View {
        Text(type.asTitle())
            .myFont(size: 17, textColor: .blue)
            .padding()
    }
    
    @ViewBuilder
    func SheetContent() -> some View {
        VStack(spacing: 4) {
            Text("Pick icon")
                .applyTextStyle()
            
            IconPicker()
            
            Text("Enter \(type.asEnterName()) name")
                .applyTextStyle()
            
            TextField("WriteName", text: $name)
                .applyFieldStyle()
            
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
    }
    
    func IconPicker() -> some View {
            Picker("", selection: $icon) {
                ForEach(allIcons, id: \.self ) { image in
                    Text.sfIcon(image, size: 15)
                }
            }.frame(width: 70)
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
//struct MyButton: View {
//    let label: String
//    
//    let txtColor: Color // Color("iconColor") .black
//    let bgColor: Color // Color("blurColor").opacity(0.8)   .primary
//    
//    let action: () -> Void
//    
//    var body: some View{
//        Button(action: action) {
//            buttonUI()
//        }
//        .buttonStyle(.plain)
//        .frame(width: 100, height: 40)
//        .frame(maxWidth: .infinity)
//    }
//    
//    func buttonUI() -> some View {
//        HStack{
//            Text(label)
//                .foregroundColor(txtColor)
//                .font(.custom("MontserratRoman-Regular", size: 17))
//        }
//        .background{
//            RoundedRectangle(cornerRadius: 12)
//                .foregroundColor(bgColor)
//                .frame(width: 70,height: 35)
//        }
//    }
//}

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
