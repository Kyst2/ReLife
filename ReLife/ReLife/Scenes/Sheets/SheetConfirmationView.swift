import SwiftUI
import MoreSwiftUI
import Essentials

struct SheetConfirmationView: View {
    let text: String
    
    var successAlertText: String? = nil
    let doNotDisableOnOk: Bool
    
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            Text(text)
                .myFont(size: 18).bold()
                .myColorWhite()
            
            HStack(spacing: 20) {
                Button(action: funcNo) {
                    Text("key.sheet.no".localized)
                        .frame(width: 40)
                }
                
                Button(action: funcYes) {
                    Text("key.sheet.yes".localized)
                        .frame(width: 40)
                }
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
            GlobalDialog.showAlert(withText: successAlertText)
        } else if doNotDisableOnOk {
            
        } else {
            GlobalDialog.close()
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
