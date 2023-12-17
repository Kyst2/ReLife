import Foundation
import SwiftUI
import MoreSwiftUI
import Realm


struct SheetWorkWithQuestView: View {
    @ObservedObject var model: SettingsViewModel
    let type: WorkWithTestsType
    let action: () -> Void
    
    @State var name: String
    @State var deteils: String
    @State var characsAndPoints: [CharacteristicsAndPoints]
    

    let allIcons = MyIcon.allCases.map{ $0.rawValue }
    
    @State private var icon: String = MyIcon.batteryFull.rawValue
    
    init(model: SettingsViewModel, type: WorkWithTestsType, quest: Quest?, action: @escaping () -> Void) {
        self.model = model
        self.type = type
//        self.repeatType = quest?.questRepeat ?? .eachWeek(days: [1])
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

extension SheetWorkWithQuestView {
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
            
            QuestRepeatTypeView()
            
            if type == .questCreator || type == .questEditor {
                CharacteristicsAndPointsListView(charAndPoints: $characsAndPoints)
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
            
            Text.sfSymbol("chevron.up.chevron.down")
                .foregroundColor(.black)
                .background( RoundedRectangle(cornerRadius: 3).padding(.horizontal, -4) )
        }
        .opacity(isHovered ? 1 : 0.8)
        .onHover{ hvr in withAnimation { self.isHovered = hvr } }
    }
}


// separate to another file
struct QuestRepeatTypeView : View {
    @State var tab: CurrentTab!
//    @Binding var repeatType: QuestRepeatType
    
    var repeatType: QuestRepeatType
    
    @State var tmpDayOfMonth = QuestRepeatType.dayOfMonth(days: [1])
    @State var tmpEachWeek = QuestRepeatType.eachWeek(days: [1])
    @State var tmpRepeatEvery = QuestRepeatType.repeatEvery(days: 30, startingFrom: Date.now.adding(days: 1) )
    @State var tmpSingleDay = QuestRepeatType.singleDayQuest(date: Date.now.adding(days: 1))
    
    init(repeatType: QuestRepeatType? = nil) {
        self.repeatType = repeatType ?? .eachWeek(days: [1])
        
        switch repeatType {
        case .dayOfMonth(let days):
            self.tab = .DayOfMonth
            self.tmpDayOfMonth = QuestRepeatType.dayOfMonth(days: days)
        case .eachWeek(let days ):
            self.tab = .DayOfWeek
            self.tmpEachWeek = QuestRepeatType.eachWeek(days: days)
        case .repeatEvery(let days, let startingFrom):
            self.tab = .RepeatEvery
            self.tmpRepeatEvery = QuestRepeatType.repeatEvery(days: days, startingFrom: startingFrom)
        case .singleDayQuest(let date):
            self.tab = .SingleDay
            self.tmpSingleDay = QuestRepeatType.singleDayQuest(date: date)
        case .none:
            self.tab = .DayOfWeek
        }
    }
    
    
    var body: some View {
        GroupBox {
            VStack{
                HStack {
                    // Radiobuttons or dropdown here
                }
                
                switch repeatType {
                case .dayOfMonth(let days):
                    DayOfMonth(days)
                case .eachWeek(let days):
                    DayOfWeek(days)
                case .repeatEvery(let everyDays, let startingFromDate):
                    RepeatEvery(days: everyDays, startfrom: startingFromDate)
                case .singleDayQuest(let date):
                    SingleDay(date: date)
                }
            }
        }
    }
    
    func DayOfMonth (_ days: [Int]) -> some View {
        EmptyView()
    }
    
    func DayOfWeek (_ days: [Int]) -> some View {
        EmptyView()
    }
    
    func RepeatEvery ( days: Int, startfrom date: Date) -> some View {
        EmptyView()
    }
    
    func SingleDay(date: Date) -> some View {
        EmptyView()
    }
}

extension QuestRepeatTypeView {
    enum CurrentTab {
        case DayOfMonth,
        DayOfWeek,
        RepeatEvery,
        SingleDay
    }
}
