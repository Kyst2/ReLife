import SwiftUI
import MoreSwiftUI

struct SheetConfirmationView: View {
    let text: String
    let action: () -> Void
    var body: some View {
        VStack{
            Text(text)
                .myFont(size: 18).bold()
                .myColorWhite()
            
            sheetButtons()
        }
        .frame(width: 400 , height: 200)
        .backgroundGaussianBlur(type: .behindWindow , material: .m1_hudWindow)
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
struct SheetButton: View {
    let label: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .myColorBlue()
                .myFont(size: 15)
        }.padding()
    }
}
