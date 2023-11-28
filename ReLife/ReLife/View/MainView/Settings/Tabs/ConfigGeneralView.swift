import SwiftUI


struct ConfigGeneralView: View {
    @State var firstWickDay: FirstWeekDay = .monday
    @State var language: Language = .english
    @State var sound = false
    var body: some View {
        ScrollView{
            VStack(spacing: 30 ){
                BDButtons()
                
                PickerGroup()
                
                ResetButtons()
                
                SoundToggle()
                
                LinkSupport()
            }
        }
    }
}

extension ConfigGeneralView {
    func BDButtons() -> some View {
        GroupBox {
            HStack{
                SettingButton(label: "ExportBD") {
                    
                }
                SettingButton(label: "ImportBD") {
                    
                }
            }
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

enum FirstWeekDay: String {
    case sunday
    case monday
}

enum Language: String {
    case english
    case german
    case ukraine
}
