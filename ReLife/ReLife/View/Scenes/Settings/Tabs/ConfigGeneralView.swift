import SwiftUI
import MoreSwiftUI

struct ConfigGeneralView: View {
    @ObservedObject var model: SettingsViewModel
    
    @State var firstWickDay: FirstWeekDay = .monday
    @State var languages: Language = .english
    @State var sound = false
    
    @State var enableDangerZone: Bool = false
    
    let columns = [ GridItem(.fixed(200)), GridItem(.fixed(200)), GridItem(.fixed(200)) ]
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                DbButtons()
                PickerFirstWeekDay()
                PickerLanguage()
                
                Spacer()
                SoundSettings()
                Spacer()
                
                Spacer()
                DangerButtons()
                Spacer()
                
                Spacer()
                LinkSupport()
                Spacer()
            }
        }
        .padding(20)
    }
}

extension ConfigGeneralView {
    func DbButtons() -> some View {
        MyGroupBox(header: "key.settings.db".localized) {
            HStack {
                Button("key.settings.db.export".localized) {
                    
                }
                
                Button("key.settings.db.import".localized) {
                    
                }
            }
            .frame(minWidth: 180, minHeight: 40)
        }
    }
    
    func PickerFirstWeekDay() -> some View {
        MyGroupBox(header: "key.settings.db.1st-weekday".localized) {
            Picker("", selection: $firstWickDay) {
                ForEach(FirstWeekDay.allCases, id: \.rawValue) { day in
                    Text(day.rawValue.localized ).tag(day)
                }
            }
            .pickerStyle(.menu)
            .frame(width: 130)
            .frame(minWidth: 180, minHeight: 40)
        }
    }
    
    func PickerLanguage() -> some View {
        MyGroupBox(header: "key.settings.db.lang".localized) {
            Picker("", selection: $languages) {
                ForEach(Language.allCases, id: \.rawValue) { language in
                    Text(language.rawValue.localized ).tag(language)
                }
            }
            .pickerStyle(.menu)
            .frame(width: 130)
            .frame(minWidth: 180, minHeight: 40)
        }
    }
    
    func DangerButtons() -> some View {
        MyGroupBox2 {
            HStack {
                Toggle("", isOn: $enableDangerZone)
                    .toggleStyle(NoLblIosToggleStyle.nolblIosStyle )
                
                Text("key.settings.db.danger".localized)
            }
        } _: {
            VStack {
                Button("key.settings.db.danger.clear-charach".localized) {
                    RealmController.shared.deleteAllOf(type: Characteristic.self)
                }
                
                Button("key.settings.db.danger.clear-quests".localized) {
                    RealmController.shared.deleteAllOf(type: Quest.self)
                }
                
                Button("key.settings.db.danger.clear-history".localized) {
                    RealmController.shared.deleteAllOf(type: History.self)
                }
            }
            .padding(.vertical, 10)
            .frame(minWidth: 180, minHeight: 40)
            .disabled(!enableDangerZone)
        }
    }
    
    func SoundSettings() -> some View {
        MyGroupBox(header: "key.settings.db.sound-stngs".localized) {
            HStack{
                Text("\("key.other.enabled".localized):")
                Toggle(isOn: $sound){ }
                    .toggleStyle(NoLblIosToggleStyle.nolblIosStyle )
            }
            .frame(minWidth: 180, minHeight: 40)
        }
        
    }
    
    func LinkSupport() -> some View {
        Link("key.settings.db.support-email".localized, destination: URL(string: "mailto:deradus@ukr.net")!)
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
    case sunday = "key.other.day.7"
    case monday = "key.other.day.1"
}

enum Language: String, CaseIterable {
    case system  = "key.other.lang.system"
    case english = "key.other.lang.eng"
    case german  = "key.other.lang.german"
    case ukraine = "key.other.lang.urk"
}
