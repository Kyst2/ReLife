import SwiftUI
import MoreSwiftUI

struct QuestsEditSheet: View {
    @Binding var dialog: SheetDialogType
    
    @Binding var name: String
    @Binding var icon: String
    @Binding var deteils: String
    var body: some View {
        ZStack{
            Color("gradient3").opacity(0.4)
            VisualEffectView(type: .behindWindow , material: .m1_hudWindow)
            VStack{
                TitleEdit()
                
                ChangeTab()
                
                Buttons()
            }
        }
        .frame(width: 600,height: 500)
    }
    
    func TitleEdit() -> some View {
        Text("Quest editing window")
            .foregroundColor(Color("textColor"))
            .font(.custom("MontserratRoman-Regular", size: 17))
            .padding()
    }
    
    @ViewBuilder
    func ChangeTab() -> some View {
        TextStyle(text: "Enter a new quest name")
        textField(title: "WriteName", text: $name)
        
        TextStyle(text: "Pick new icon")
        textField(title: "Quest Icon", text: $icon)
        
        TextStyle(text: "update the new details of the quest")
        TextEditorDeteils()
    }
    
    func TextStyle(text:String) -> some View {
        Text(text)
            .foregroundColor(Color("textColor"))
            .font(.custom("MontserratRoman-Regular", size: 13)).italic()
        
    }
    
    func textField(title: String, text: Binding<String>) -> some View {
        TextField(title, text: text)
            .textFieldStyle(.roundedBorder)
            .foregroundColor(Color("textColor"))
            .font(.custom("MontserratRoman-Regular", size: 15))
            .padding()
    }
    
    func TextEditorDeteils() -> some View {
        TextEditor(text: $deteils)
            .frame(minHeight: 60)
            .cornerRadius(10)
            .padding(10)
            .font(.custom("MontserratRoman-Regular", size: 13)).italic()
            .foregroundColor(Color("textColor"))
        
    }
    
    func Buttons() -> some View {
        HStack{
            SaveButton(label: "Save") {
                
            }
            SaveButton(label: "Cancel") {
                dialog = .none
            }
        }
    }
}




////////////////
///HELPERS
////////////////
struct SaveButton: View {
    let label: String
    let action: () -> Void
    
    var body: some View{
        Button {
            action()
        } label: {
            HStack{
                if label == "Save"{
                    Text(label)
                        .foregroundColor(Color("iconColor"))
                        .font(.custom("MontserratRoman-Regular", size: 17))
                } else {
                    Text(label)
                        .foregroundColor(.black)
                        .font(.custom("MontserratRoman-Regular", size: 17))
                }
            }
        }
        .buttonStyle(.plain)
        .frame(width: 100,height: 40)
        .background{
            if label == "Save"{
                RoundedRectangle(cornerRadius: 12)
                
                    .foregroundColor(Color("blurColor")).opacity(0.8)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .fixedSize()
        .frame(maxWidth: .infinity)
        
    }
}
