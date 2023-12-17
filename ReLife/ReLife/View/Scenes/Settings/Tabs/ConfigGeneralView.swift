import SwiftUI
import MoreSwiftUI

struct ConfigGeneralView: View {
    @ObservedObject var model: SettingsViewModel
    
    @State var firstWickDay: FirstWeekDay = .monday
    @State var languages: Language = .english
    @State var sound = false
    
    let columns = [ GridItem(.fixed(200)), GridItem(.fixed(200)), GridItem(.fixed(200)) ]
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                DbButtons()
                
                PickerFirstWeekDay()
                
                PickerLanguage()
                
                HistoryClearButton()
                
                SoundSettings()
                
                Spacer()
                
                Spacer()
                
                LinkSupport()
            }
        }
        .padding(20)
    }
}

extension ConfigGeneralView {
    func DbButtons() -> some View {
        MyGroupBox(header: "Database actions") {
            HStack {
                Button("Export") {
                    
                }
                
                Button("Import") {
                    
                }
            }
            .frame(minWidth: 180, minHeight: 40)
        }
    }
    
    func PickerFirstWeekDay() -> some View {
        MyGroupBox(header: "First Day of week") {
            Picker("", selection: $firstWickDay) {
                ForEach(FirstWeekDay.allCases, id: \.rawValue) { day in
                    Text(day.rawValue).tag(day)
                }
            }
            .pickerStyle(.menu)
            .frame(width: 130)
            .frame(minWidth: 180, minHeight: 40)
        }
    }
    
    func PickerLanguage() -> some View {
        MyGroupBox(header: "Language") {
            Picker("", selection: $languages) {
                ForEach(Language.allCases, id: \.rawValue) { language in
                    Text(language.rawValue).tag(language)
                }
            }
            .pickerStyle(.menu)
            .frame(width: 130)
            .frame(minWidth: 180, minHeight: 40)
        }
    }
    
    func HistoryClearButton() -> some View {
        MyGroupBox(header: "History") {
            Button("Clear") { }
                .frame(minWidth: 180, minHeight: 40)
        }
    }
    
    func SoundSettings() -> some View {
        MyGroupBox(header: "Sound Settings") {
            Toggle(isOn: $sound){
                Text("Enabled")
                    .foregroundColor(Color("iconColor"))
                    .font(.custom("MontserratRoman-Regular", size: 17))
            }
            .toggleStyle(SwitchToggleStyle(tint: Color("textColor")))
            .frame(minWidth: 180, minHeight: 40)
        }
        
    }
    
    func LinkSupport() -> some View {
        Link("Support Email", destination: URL(string: "mailto:deradus@ukr.net")!)
            .padding(.bottom, 20)
    }
}

/////////////////
///HELPERS
/////////////////

struct TitleText: View {
    let txt: String
    
    init(_ text: String) {
        self.txt = text
    }
    
    var body: some View {
        Text(txt)
            .font(.moncerat(size: 20))
    }
}

enum FirstWeekDay: String, CaseIterable {
    case sunday = "Sunday"
    case monday = "Monday"
}

enum Language: String, CaseIterable {
    case system  = "System"
    case english = "Engilsh"
    case german  = "German"
    case ukraine = "Ukraine"
}
