import SwiftUI
import MoreSwiftUI

struct ConfigGeneralView: View {
    @State var firstWickDay: FirstWeekDay = .monday
    @State var languages: Language = .english
    @State var sound = false
    var body: some View {
        ScrollView {
            GroupBox {
                VStack(spacing: 30) {
                    DbButtons()
                    
                    PickerFirstWeekDay()
                    
                    PickerLanguage()
                    
                    ResetButtons()
                    
                    SoundToggle()
                    
                    LinkSupport()
                }
            }
        }
        .padding(20)
    }
}

extension ConfigGeneralView {
    func DbButtons() -> some View {
            VStack(alignment: .leading) {
                VStack{
                    TitleText("Database actions")
                    
                    HStack{
                        SettingButton(label: "Export") {
                            
                        }
                        
                        SettingButton(label: "Import") {
                            
                        }
                    }
                }
                .fillParent()
                .padding(20)
            }
    }
    
    func PickerGroup() -> some View {
        GroupBox {
            HStack{
                PickerFirstWeekDay()
                
                PickerLanguage()
            }
        }
    }
    
    func PickerFirstWeekDay() -> some View {
        VStack(spacing: 20) {
            TitleText("First Day of week")
            
            Picker("", selection: $firstWickDay) {
                ForEach(FirstWeekDay.allCases, id: \.rawValue) { day in
                    Text(day.rawValue).tag(day)
                }
            }
            .pickerStyle(.menu)
            .frame(width: 130)
        }
    }
    
    func PickerLanguage() -> some View {
        VStack(spacing: 20) {
            TitleText("Language")
            
            Picker("", selection: $languages) {
                ForEach(Language.allCases, id: \.rawValue) { language in
                    Text(language.rawValue).tag(language)
                }
            }
            .pickerStyle(.menu)
            .frame(width: 130)
        }
    }
    
    func ResetButtons() -> some View {
        GroupBox {
            HStack{
                SettingButton(label: "delete all history") {
                    
                }
                SettingButton(label: "reset to default settings") {
                    
                }
            }
        }
    }
    
    func SoundToggle() -> some View {
        Toggle(isOn: $sound){
            Text("Sound")
                .foregroundColor(Color("iconColor"))
                .font(.custom("MontserratRoman-Regular", size: 17))
        }
        .toggleStyle(SwitchToggleStyle(tint: Color("textColor")))
    }
    
    func LinkSupport() -> some View {
        Link("Support Email", destination: URL(string: "mailto:deradus@ukr.net")!)
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
//    case system
    case english = "Engilsh"
    case german = "German"
    case ukraine = "Ukraine"
}
