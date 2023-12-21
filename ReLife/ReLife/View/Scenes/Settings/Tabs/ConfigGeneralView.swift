import SwiftUI
import MoreSwiftUI

struct ConfigGeneralView: View {
    @ObservedObject var model: SettingsViewModel
    
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
            Picker("", selection: $model.firstWeeckDay) {
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
            Picker("", selection: $model.currLang) {
                ForEach(Language.allCases, id: \.rawValue) { language in
                    Text(language.rawValue.localized ).tag(language)
                }
            }
            .pickerStyle(.menu)
            .frame(width: 130)
            .frame(minWidth: 180, minHeight: 40)
            .onChange(of: model.currLang, perform: {
                forceCurrentLocale = $0.asLocaleName()
                MyApp.signals.send(signal: RLSignal.LanguageChaned() )
            })
        }
    }
    
    func DangerButtons() -> some View {
        MyGroupBox2 {
            HStack {
                Toggle("", isOn: $enableDangerZone)
                    .toggleStyle( .nolblIosStyle )
                
                Text("key.settings.db.danger".localized)
            }
        } _: {
            VStack {
                let successAlert = "key.sheet.success".localized
                
                Button("key.settings.db.danger.clear-charach".localized) {
                    let dialogText = "\("key.settings.db.danger.clear-charach".localized)?"
                    
                    GlobalDialog.shared
                        .confirmDialogYesNo(withText: dialogText, successAlertText: successAlert)
                    {
                        RealmController.shared.deleteAllOf(type: Characteristic.self)
                        MyApp.signals.send(signal: RLSignal.ReloadData() )
                    }
                }
                
                Button("key.settings.db.danger.clear-quests".localized) {
                    let dialogText = "\("key.settings.db.danger.clear-quests".localized)?"
                    
                    GlobalDialog.shared
                        .confirmDialogYesNo(withText: dialogText, successAlertText: successAlert)
                    {
                        RealmController.shared.deleteAllOf(type: Quest.self)
                        MyApp.signals.send(signal: RLSignal.ReloadData() )
                    }
                }
                
                Button("key.settings.db.danger.clear-history".localized) {
                    let dialogText = "\("key.settings.db.danger.clear-history".localized)?"
                    
                    GlobalDialog.shared
                        .confirmDialogYesNo(withText: dialogText, successAlertText: successAlert)
                    {
                        RealmController.shared.deleteAllOf(type: History.self)
                        MyApp.signals.send(signal: RLSignal.ReloadData() )
                    }
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
                Toggle(isOn: $model.sound){ }
                    .toggleStyle( .nolblIosStyle )
            }
            .frame(minWidth: 180, minHeight: 40)
        }
        
    }
    
    func LinkSupport() -> some View {
        VStack {
            Button("About") { }
                .buttonStyle(.link)
            
            Link("key.settings.db.support-email".localized, destination: URL(string: "mailto:deradus@ukr.net")!)
                .padding(.bottom, 20)
        }
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
    case ukrainian = "key.other.lang.urk"
}

extension Language {
    func asLocaleName() -> String? {
        switch self {
        case .english:
            return "en"
        case .ukrainian:
            return "uk"
        case .german:
            return "ge"
        case .system:
            return nil
        }
    }
}
