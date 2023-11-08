import SwiftUI
import MoreSwiftUI

struct QuestsEditSheet: View {
    @State var name: String = ""
    @State var icon: String = ""
    @State var deteils: String = ""
    
    var body: some View {
        VStack {
            Title()
            
            SheetContent()
            
            Buttons()
        }
        .backgroundGaussianBlur(type: .behindWindow , material: .m1_hudWindow, color: Color(rgbaHex: 0x00ff0050))
        .frame(width: 600,height: 500)
    }
}

extension QuestsEditSheet {
    func Title() -> some View {
        Text("Quest editing window")
            .foregroundColor(Color("textColor"))
            .font(.custom("MontserratRoman-Regular", size: 17))
            .padding()
    }
    
    @ViewBuilder
    func SheetContent() -> some View {
        Text("Enter a new quest name")
            .applyTextStyle()
        
        TextField("WriteName", text: $name)
            .applyFieldStyle()
        
        Text("Pick new icon")
            .applyTextStyle()
        
        TextField("Quest Icon", text: $icon)
            .applyFieldStyle()
        
        Text("update the new details of the quest")
            .applyTextStyle()
        
        TextEditor(text: $deteils)
            .frame(minHeight: 60)
            .cornerRadius(10)
            .padding(10)
            .font(.custom("MontserratRoman-Regular", size: 13)).italic()
            .foregroundColor(Color("textColor"))
    }
    
    func Buttons() -> some View {
        HStack {
            MyButton(label: "Save", txtColor: Color("iconColor"), bgColor: Color("blurColor").opacity(0.8)) {
                
                GlobalDialog.shared.dialog = .none
            }
            
            MyButton(label: "Cancel", txtColor: .black, bgColor: .primary) {
                GlobalDialog.shared.dialog = .none
            }
        }
    }
}




////////////////
///HELPERS
////////////////
fileprivate struct MyButton: View {
    let label: String
    
    let txtColor: Color // Color("iconColor") .black
    let bgColor: Color // Color("blurColor").opacity(0.8)   .primary
    
    let action: () -> Void
    
    var body: some View{
        Button(action: action) {
            buttonUI()
        }
        .buttonStyle(.plain)
        .frame(width: 100, height: 40)
        .frame(maxWidth: .infinity)
    }
    
    func buttonUI() -> some View {
        HStack{
            Text(label)
                .foregroundColor(txtColor)
                .font(.custom("MontserratRoman-Regular", size: 17))
        }
        .background{
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(bgColor)
        }
    }
}

fileprivate extension Text {
    func applyTextStyle() -> some View {
        self
            .foregroundColor(Color("textColor"))
            .font(.custom("MontserratRoman-Regular", size: 13)).italic()
    }
}

fileprivate extension TextField {
    func applyFieldStyle() -> some View {
        self
            .textFieldStyle(.roundedBorder)
            .foregroundColor(Color("textColor"))
            .font(.custom("MontserratRoman-Regular", size: 15))
            .padding()
    }
}
