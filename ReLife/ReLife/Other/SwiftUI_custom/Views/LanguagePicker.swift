import Foundation
import SwiftUI
import MoreSwiftUI
import AppCoreLight

struct LanguagePicker: View {
    @Binding var currLang: Language
    
    var body: some View {
        Picker("", selection: $currLang) {
            ForEach(Language.allCases, id: \.rawValue) { language in
                Text(language.rawValue.localized ).tag(language)
            }
        }
        .pickerStyle(.menu)
        .frame(maxWidth: 180, minHeight: 40)
        .onChange(of: currLang, perform: {
            forceCurrentLocale = $0.asLocaleName()
            MyApp.signals.send(signal: RLSignal.LanguageChaned() )
        })
    }
}
