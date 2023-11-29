import SwiftUI
import MoreSwiftUI

struct ConfigGeneralView: View {
    @State var firstWickDay: FirstWeekDay = .monday
    @State var language: Language = .english
    @State var sound = false
    var body: some View {
        ScrollView {
            GroupBox {
                VStack(spacing: 30) {
                    DbButtons()
                    
                    VStack(spacing: 20) {
                        TitleText("First Day of week")
                        
                        Picker("", selection: $firstWickDay) {
                            ForEach(FirstWeekDay.allCases, id: \.rawValue) { day in
                                Text(day.rawValue).tag(day.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(width: 130)
                    }
                    
                    //TODO: fix me
                    VStack(spacing: 20) {
                        TitleText("Language")
                        
                        Picker("", selection: $language) {
                            Text("English").tag(Language.english)
                            Text("German").tag(Language.german)
                            Text("Ukraine").tag(Language.ukraine)
                        }
                        .pickerStyle(.menu)
                        .frame(width: 130)
                    }
                    
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
        VStack(spacing: 20){
            Text("First week day")
                .myFont(size: 17, textColor: .white)
            
            Picker("", selection: $firstWickDay) {
                Text("Sunday").tag(FirstWeekDay.sunday)
                Text("Monday").tag(FirstWeekDay.monday)
            }
            .pickerStyle(.menu)
        }.padding()
    }
    
    func PickerLanguage() -> some View {
        VStack(spacing: 20){
            Text("Wich of Language ?")
                .myFont(size: 17, textColor: .white)
            
            Picker("", selection: $language) {
                Text("English").tag(Language.english)
                Text("German").tag(Language.german)
                Text("Ukraine").tag(Language.ukraine)
            }
            .pickerStyle(.menu)
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
    case system
    case english
    case german
    case ukraine
}
