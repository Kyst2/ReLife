import SwiftUI
import MoreSwiftUI
import Essentials

struct SheetConfirmationView: View {
    let text: String
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
        .keyboardReaction { evnt in
            switch evnt.keyCode {
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
}

extension SheetConfirmationView {
    func funcNo() {
        GlobalDialog.shared.dialog = .none
    }
    
    func funcYes() {
        action()
        GlobalDialog.shared.dialog = .none
    }
}

/////////////////
///HELPERS
/////////////////

