import SwiftUI
import MoreSwiftUI

class GlobalDialog: ObservableObject {
    static var shared = GlobalDialog()
    
    @Published var dialog: SheetDialogType = .none
    
    private init() {}
    
    static func showAlert(withText: String) {
        let alert = AnyView(SheetAlertView(text: withText))
        
        GlobalDialog.shared.dialog = .view(view: alert)
    }
    
    static func confirmDialogYesNo(withText: String, successAlertText: String? = nil, action: @escaping () -> ()) {
        let alert = AnyView(SheetConfirmationView(text: withText, successAlertText: successAlertText, action: action))
        
        GlobalDialog.shared.dialog = .view(view: alert)
    }
    
    static func close() {
        GlobalDialog.shared.dialog = .none
    }
}
