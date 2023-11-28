import SwiftUI
import MoreSwiftUI

struct SheetConfirmationView: View {
    let text: String
    let action: () -> Void
    var body: some View {
        VStack{
            SheetText()
            
            sheetButtons()
        }
        .frame(width: 400 , height: 200)
        .backgroundGaussianBlur(type: .behindWindow , material: .m1_hudWindow)
    }
    
    func SheetText() -> some View {
        Text(text)
            .myFont(size: 18, textColor: .white).bold()
            .myColorWhite()
    }
    
    func sheetButtons() -> some View {
        HStack{
            MyButton(label: "Yes", txtColor: Color("iconColor"), bgColor: Color("blurColor")) {
                action()
                GlobalDialog.shared.dialog = .none
            }
            MyButton(label: "No", txtColor: .black, bgColor: .primary) {
                GlobalDialog.shared.dialog = .none
            }
        }
    }
}

/////////////////
///HELPERS
/////////////////

