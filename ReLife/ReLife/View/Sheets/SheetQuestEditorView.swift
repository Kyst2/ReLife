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
    @State var questColor: Color = Color.white
    
    @State private var icon: String = MyIcon.batteryFull.rawValue
    
    init(model: SettingsViewModel, type: WorkWithTestsType, quest: Quest?, action: @escaping () -> Void) {
        self.model = model
        self.type = type
        self.name = quest?.name ?? ""
        self.deteils = quest?.descript ?? ""
        
        if let quest {
            self.icon = type == .questEditor ? quest.icon.rawValue : MyIcon.batteryFull.rawValue
        } else {
            self.icon = MyIcon.batteryFull.rawValue
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
            .myFont(size: 17, textColor: .blue)
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
                    .foregroundColor(questColor)
                
                IconPicker(icon: $icon)
                    .foregroundColor(questColor)
                
                //заміни на власний пікер аналогічний ікон пікера з тим набором кольорів який я просив
                UksColorPicker(color: $questColor)
                    .frame(width: 20, height: 20)
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
            .font(.custom("MontserratRoman-Regular", size: 15))
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

struct CharacteristicsAndPointsListView: View {
    @Binding var charAndPoints: [CharacteristicsAndPoints]
    
    var body: some View {
        GroupBox{
            ScrollView {
                VStack(spacing: 10){
                    ForEach(charAndPoints) { pair in
                        HStack {
                            Text(pair.charac.name)
                            
                            Spacer()
                            
                            NumUpDown(allPairs: $charAndPoints, thisPair: pair)
                        }
                    }
                }
            }
            .frame(height: 130)
            .padding(.horizontal, 15)
        }
    }
}

struct NumUpDown: View {
    @State private var isHovered: Bool = false
    
    @Binding var allPairs: [CharacteristicsAndPoints]
    
    public let thisPair: CharacteristicsAndPoints
    @State var isEditing = false
    
    var body: some View {
        let points = Array(0...10).map{ $0 * 5 }
        
        PopoverButt(edge: .leading, isPresented: $isEditing, TrueBody) {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(points, id: \.self) { currPoints in
                        Text("\(currPoints)")
                            .onTapGesture {
                                guard let idx = allPairs.firstIndex(of: thisPair) else { return }
                                
                                allPairs[idx] = CharacteristicsAndPoints(id: thisPair.id, charac: thisPair.charac, points: currPoints)
                                
                                isEditing = false
                            }
                    }
                }
            }
            .padding( EdgeInsets(horizontal: 20, vertical: 10) )
        }
    }
    
    func TrueBody() -> some View {
        HStack {
            Text("\(thisPair.points)")
        }
        .opacity(isHovered ? 1 : 0.8)
        .onHover{ hvr in withAnimation { self.isHovered = hvr } }
    }
}


// separate to another file
struct QuestRepeatTypeView : View {
    @State var repeatTypeCurr: CurrentTab = .SingleDay
    //@Binding
    var repeatType: QuestRepeatType
    
    @State var tmpSingleDay: Date = Date.now
    @State var tmpDayOfMonth = [1]
    @State var tmpEachWeek = [1]
    @State var tmpRepeatEveryDays = 1
    @State var tmpRepeatEveryStartFrom = Date.now.adding(days: 1)
  
    init(repeatType: QuestRepeatType? = nil) {
        //assign binding
        //_repeatType = repeatType
        self.repeatType = repeatType ?? .eachWeek(days: [1])
        
        switch repeatType {
        case .dayOfMonth(let days):
            self.repeatTypeCurr = .DayOfMonth
            self.tmpDayOfMonth = days
        case .eachWeek(let days ):
            self.repeatTypeCurr = .DayOfWeek
            self.tmpEachWeek = days
        case .repeatEvery(let days, let startingFrom):
            self.repeatTypeCurr = .RepeatEvery
            self.tmpRepeatEveryDays = days
            tmpRepeatEveryStartFrom = startingFrom
        case .singleDayQuest(let date):
            self.repeatTypeCurr = .SingleDay
            self.tmpSingleDay = date
        case .none:
            self.repeatTypeCurr = .DayOfWeek
        }
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Picker(selection: $repeatTypeCurr) {
                    ForEach(CurrentTab.allCases, id: \.self) { current in
                        Text(current.rawValue.localized.capitalized ).tag(current)
                    }
                } label: {
                    Text("")
                }
                .pickerStyle(.radioGroup)
                .horizontalRadioGroupLayout()
                
                Spacer()
            }
            
            Space(10)
            
            GroupBox {
                switch repeatTypeCurr {
                case .DayOfMonth:
                    DayOfMonth()
                case .DayOfWeek:
                    DayOfWeek()
                case .RepeatEvery:
                    RepeatEvery()
                case .SingleDay:
                    SingleDay()
                }
            }
        }
    }
    
    func DayOfMonth () -> some View {
        //textField with syntax: 1-5,8-10,11,32
//        .onChange(of: tmpSingleDay, perform: { _ in
        //обробка синтаксису цього поля!
////                self.repeatType = .singleDayQuest(date: $0)
//        })
        EmptyView()
    }
    
    func DayOfWeek () -> some View {
        //7 toggles [monday-sunday | sunday - saturday - depends on settings in global tab]
//        .onChange(of: tmpSingleDay, perform: { _ in
////                self.repeatType = .singleDayQuest(date: $0)
//        })
        EmptyView()
    }
    
    func RepeatEvery() -> some View {
        HStack {
            Spacer()
            
            Text("Repeat every")
            
            NumericUpDown(value: $tmpRepeatEveryDays)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 60)
            
            Text("up from")
            
            DatePicker("", selection: $tmpRepeatEveryStartFrom, in: Date()...Date.distantFuture, displayedComponents: [.date])
                .labelsHidden()
                .onChange(of: tmpSingleDay, perform: { _ in
                    //                self.repeatType = .singleDayQuest(date: $0)
                })
            //date picker "start from date"
            //        .onChange(of: tmpSingleDay, perform: { _ in
            ////                self.repeatType = .singleDayQuest(date: $0)
            //        })
            
            Spacer()
        }
    }
    
    func SingleDay() -> some View {
        HStack {
            Spacer()
            
            Text("\("key.other.date".localized ):")
            
            VStack {
                DatePicker("", selection: $tmpSingleDay, in: Date()...Date.distantFuture, displayedComponents: [.date])
                    .labelsHidden()
                    .onChange(of: tmpSingleDay, perform: { _ in
                        //                self.repeatType = .singleDayQuest(date: $0)
                    })
            }
            
            Spacer()
        }
    }
}

extension QuestRepeatTypeView {
    enum CurrentTab: String, CaseIterable {
        case DayOfMonth = "key.sheet.repeatType.month-day"
        case DayOfWeek = "key.sheet.repeatType.week-day"
        case RepeatEvery = "key.sheet.repeatType.repeat-every"
        case SingleDay = "key.sheet.repeatType.single-day"
    }
}

//move to another place!
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}

struct ChevronUpDown: View {
    var body: some View {
        Text.sfSymbol("chevron.up.chevron.down")
            .foregroundColor(.black)
            .background( RoundedRectangle(cornerRadius: 3).padding(.horizontal, -4) )
    }
}


struct IconPicker: View {
    @Binding var icon: String
    @State private var iconPickerShown = false
    
    let allIcons = MyIcon.allCases.map{ $0.rawValue }
    
    let columns = (1...10).map { _ in GridItem(.fixed(35)) }
    
    var body: some View {
        PopoverButt(edge: .leading, isPresented: $iconPickerShown, { Label(icon) } ) {
            LazyVGrid(columns: columns, content: {
                ForEach(allIcons, id: \.self ) { image in
                    Button(action: { icon = image; iconPickerShown = false }) {
                        Label(image, size: 26)
                            .overlay( Selection(image:image).padding(-6) )
                    }
                    .buttonStyle(BtnUksStyle.default)
                }
            })
            .padding(25)
        }
        .buttonStyle(BtnUksStyle.default)
    }
    
    func Label(_ img: String, size: CGFloat = 20) -> some View {
        Text.sfIcon2(img, size: size)
    }
    
    @ViewBuilder
    func Selection(image: String) -> some View {
        if icon == image {
            Circle()
                .stroke(Color.primary, lineWidth: 2)
        } else {
            Color.clear
        }
    }
}

public extension Text {
    static func sfIcon2( _ sysName: String, size: CGFloat) -> some View {
        return Image(systemName: sysName)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}
