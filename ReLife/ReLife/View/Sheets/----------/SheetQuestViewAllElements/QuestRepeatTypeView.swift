import SwiftUI
import MoreSwiftUI

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
        HStack{
            ForEach(DaysOfWeek.allCases, id: \.self) { day in
                
            }
        }
        //7 toggles [monday-sunday | sunday - saturday - depends on settings in global tab]
//        .onChange(of: tmpSingleDay, perform: { _ in
////                self.repeatType = .singleDayQuest(date: $0)
//        })
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
    enum DaysOfWeek: Int, CaseIterable {
            case sunday = 0, monday, tuesday, wednesday, thursday, friday, saturday
        }
}
