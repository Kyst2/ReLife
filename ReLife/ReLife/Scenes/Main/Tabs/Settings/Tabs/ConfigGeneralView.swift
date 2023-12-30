import SwiftUI
import MoreSwiftUI

struct ConfigGeneralView: View {
    @ObservedObject var model: SettingsViewModel
    
    @State var enableDangerZone: Bool = false
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                VStack {
                    PickerLanguage()
                    
                    #if DEBUG
                    AchievementSettings()
                    #endif
                    
                    DbButtons()
                        .opacity(0.6)
                        .disabled(true)
                    
                    SoundSettings()
                        .opacity(0.6)
                        .disabled(true)
                }
                
                VStack {
                    DangerButtons()
                    
                    LinkSupport()
                }
            }
        }
        .padding(20)
    }
}

extension ConfigGeneralView {
    func DbButtons() -> some View {
        MyGroupBox(header: "key.settings.db".localized) {
            HStack {
                Space(20)
                
                //EXPORT
                Button(action: { }) {
                    Text.sfIcon2(RLIcons.dbExport, size: 30)
                        .padding(3)
                }
                
                // Import
                Button(action: { }) {
                    Text.sfIcon2(RLIcons.dbImport, size: 30)
                        .padding(3)
                }
                
                Spacer()
            }
            .padding(4)
            .frame(minWidth: 180, minHeight: 40)
        }
    }
    
    func PickerLanguage() -> some View {
        MyGroupBox2(headerView: { EmptyView() } ) {
            HStack {
                Space(20)
                
                Text.sfIcon2(RLIcons.language, size: 20)
                
                Picker("", selection: $model.currLang) {
                    ForEach(Language.allCases, id: \.rawValue) { language in
                        Text(language.rawValue.localized ).tag(language)
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: 180, minHeight: 40)
                .onChange(of: model.currLang, perform: {
                    forceCurrentLocale = $0.asLocaleName()
                    MyApp.signals.send(signal: RLSignal.LanguageChaned() )
                })
                
                Spacer()
            }
        }
    }
    
    func DangerButtons() -> some View {
        MyGroupBox2 {
            HStack {
                Toggle("", isOn: $enableDangerZone)
                    .toggleStyle( .nolblIosStyle )
                
                HStack(spacing: 0) {
                    Text.sfIcon2(RLIcons.danger, size: 20)
                        .padding(.horizontal, -2)
                    Text.sfIcon2(RLIcons.danger, size: 20)
                        .padding(.horizontal, -2)
                    Text.sfIcon2(RLIcons.danger, size: 20)
                        .padding(.horizontal, -2)
                }
                .foregroundColor(.yellow)
            }
        } _: {
            VStack(alignment: .leading) {
                BtnAddDefaultQuests()
                
                HStack {
                    VStack {
                        Divider()
                    }
                    .frame(width: 220)
                    
                    Spacer()
                }
                
                BtnCleanCharacts()
                
                BtnCleanQuests()
                
                BtnCleanHistory()
                
                BtnCleanAchievements()
            }
            .padding(.vertical, 10)
            .padding(.leading, 20)
            .disabled(!enableDangerZone)
        }
    }
    
    func SoundSettings() -> some View {
        MyGroupBox2 {
            HStack {
                Toggle(isOn: $model.soundEnabled){ }
                    .toggleStyle( .nolblIosStyle )
                
                Text.sfIcon2(RLIcons.sound, size: 15)
            }
        } _: {
            HStack {
                Space()
            }
            .padding(.leading, 20)
            .frame(minWidth: 180, minHeight: 40)
        }
    }
    
    func AchievementSettings() -> some View {
        MyGroupBox2 {
            HStack {
                Toggle(isOn: $model.achievementEnabled){ }
                    .toggleStyle( .nolblIosStyle )
                
                Text.sfIcon2(RLIcons.achievementEmpty, size: 15)
            }
            
        } _: {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Birthday* ")
                        
                        DatePicker("", selection: $model.birthDay, displayedComponents: [.date])
                    }
                    .help("Some predefined quests is relative to your birthday. Some Achievements is related to such quests.")
                    
                    HStack {
                        Toggle(isOn: $model.isMale){ }
                            .toggleStyle( .nolblIosStyle )
                        
                        Text.sfSymbol(RLIcons.gender)
                            .font(.custom("SF Pro", size: 25))
                            .padding(
                                model.isMale ? EdgeInsets(top: 0, leading: -23, bottom: 0, trailing: 0) :
                                               EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -20)
                            )
                            .mask(Rectangle().fill(.black))
                            .allowsHitTesting(false)
                            .padding(.leading, model.isMale ? 2 : 0)
                    }
                    
                    HStack {
                        Toggle(isOn: .constant(true)){ }
                            .toggleStyle( .nolblIosStyle )
                        
                        Text("😈 achievements")
                    }
                }
                .disabled(!model.achievementEnabled)
                .opacity(model.achievementEnabled ? 1 : 0.6)
                
                Space()
            }
            .padding(.leading, 20)
            .padding(.vertical, 10)
            .frame(minWidth: 180, minHeight: 40)
        }
    }
    
    func LinkSupport() -> some View {
        VStack {
            Button("key.settings.about".localized("ReLife") ) {
                let view = AnyView( SheetAbout() )
                GlobalDialog.shared.dialog = .view(view: view)
            }
            .buttonStyle(.link)
            
            Link("key.settings.support-email".localized, destination: URL(string: "mailto:deradus@ukr.net")!)
                .padding(.bottom, 20)
        }
        .foregroundColor(RLColors.brown)
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

fileprivate struct BtnAddDefaultQuests: View {
    var body: some View {
        Button {
            GlobalDialog.shared.dialog = .view(view: AnyView(SheetAddStandardData() ))
        } label: {
            Text("Add default Quests")// TODO translate me!
                .frame(width: 200)
        }
    }
}

fileprivate struct BtnCleanCharacts: View {
    var body: some View {
        let successAlert = "key.sheet.success".localized
        
        Button {
            let dialogText = "\("key.settings.danger.clear-charach".localized)?"
            
            GlobalDialog.confirmDialogYesNo(withText: dialogText, successAlertText: successAlert)
            {
                RealmController.shared.deleteAllOf(type: Characteristic.self)
                MyApp.signals.send(signal: RLSignal.ReloadData() )
            }
        } label: {
            Text("key.settings.danger.clear-charach".localized)
                .frame(width: 200)
        }
    }
}

fileprivate struct BtnCleanQuests: View {
    var body: some View {
        let successAlert = "key.sheet.success".localized
        
        Button {
            let dialogText = "\("key.settings.danger.clear-quests".localized)?"
            
            GlobalDialog.confirmDialogYesNo(withText: dialogText, successAlertText: successAlert)
            {
                RealmController.shared.deleteAllOf(type: Quest.self)
                MyApp.signals.send(signal: RLSignal.ReloadData() )
            }
        } label: {
            Text("key.settings.danger.clear-quests".localized)
                .frame(width: 200)
        }
    }
}

fileprivate struct BtnCleanHistory: View {
    var body: some View {
        let successAlert = "key.sheet.success".localized
        
        Button {
            let dialogText = "\("key.settings.danger.clear-history".localized)?"
            
            GlobalDialog.confirmDialogYesNo(withText: dialogText, successAlertText: successAlert)
            {
                RealmController.shared.deleteAllOf(type: History.self)
                MyApp.signals.send(signal: RLSignal.ReloadData() )
            }
        } label: {
            Text("key.settings.danger.clear-history".localized)
                .frame(width: 200)
        }
    }
}

fileprivate struct BtnCleanAchievements: View {
    var body: some View {
        let successAlert = "key.sheet.success".localized
        
        Button {
            let dialogText = "\("key.settings.danger.clear-achievement".localized)?"
            
            GlobalDialog.confirmDialogYesNo(withText: dialogText, successAlertText: successAlert)
            {
                
            }
        } label: {
            Text("key.settings.danger.clear-achievement".localized)
                .frame(width: 200)
        }
    }
}
