import SwiftUI
import MoreSwiftUI
import Essentials

struct SheetConfirmationView: View {
    let text: String
    
    var successAlertText: String? = nil
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text(text)
                .myFont(size: 18, textColor: .white).bold()
                .myColorWhite()
            
            HStack {
                Button("key.sheet.no".localized) { funcNo() }
                
                Button("key.sheet.yes".localized) { funcYes() }
            }
        }
        .padding(30)
        .backgroundGaussianBlur(type: .withinWindow , material: .m1_hudWindow)
        .keyboardReaction { hotkeys($0) }
    }
}

extension SheetConfirmationView {
    func funcNo() {
        GlobalDialog.shared.dialog = .none
    }
    
    func funcYes() {
        action()
        
        if let successAlertText {
            GlobalDialog.shared.showAlert(withText: successAlertText)
        } else {
            GlobalDialog.shared.dialog = .none
        }
    }
}

/////////////////
///HELPERS
/////////////////

extension SheetConfirmationView {
    func hotkeys(_ evnt: NSEvent) -> NSEvent? {
        switch evnt.keyCode {
        case KeyCode.space:
            fallthrough
        case KeyCode.enter:
            fallthrough
        case KeyCode.keypadEnter:
            fallthrough
        case KeyCode.returnKey:
            funcYes()
            
        case KeyCode.escape:
            funcNo()
        default:
            return evnt
        }
        
        return nil
    }
}
