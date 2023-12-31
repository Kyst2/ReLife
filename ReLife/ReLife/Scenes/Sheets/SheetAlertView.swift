import SwiftUI
import MoreSwiftUI
import Essentials

struct SheetAlertView: View {
    let text: String
    var body: some View {
        VStack {
            Text(text)
                .myFont(size: 18).bold()
                .myColorWhite()
            
            HStack {
                Button("key.sheet.ok".localized, role: .cancel) { funcOK() }
            }
        }
        .padding(30)
        .backgroundGaussianBlur(type: .behindWindow, material: .m1_hudWindow)
        .keyboardReaction { hotkeys($0) }
    }
}

extension SheetAlertView {
    func funcOK() {
        GlobalDialog.shared.dialog = .none
    }
}

/////////////////
///HELPERS
/////////////////

extension SheetAlertView {
    func hotkeys(_ evnt: NSEvent) -> NSEvent? {
        switch evnt.keyCode {
        case KeyCode.space:
            fallthrough
        case KeyCode.enter:
            fallthrough
        case KeyCode.keypadEnter:
            fallthrough
        case KeyCode.returnKey:
            fallthrough
        case KeyCode.escape:
            funcOK()
            return nil
        default:
            break
        }
        
        return evnt
    }
}
