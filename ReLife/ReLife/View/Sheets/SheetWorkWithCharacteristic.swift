import SwiftUI
import MoreSwiftUI

struct SheetWorkWithCharacteristic: View {
    @State var name: String = ""
    @State var deteils: String = ""
    
    @State private var icon: String = ""
    var body: some View {
        ZStack{
            Color("gradient3").opacity(0.4)
            VisualEffectView(type: .behindWindow , material: .m1_hudWindow)
            VStack{
                TitleEdit()
                
                ChangeTab()
                
//                CharactAndPoints()
                
                CreateAndCancelButtons()
            }
        }
        .frame(width: 700,height: 600)
    }
    
    func TitleEdit() -> some View {
        Text("Quest Creating")
            .foregroundColor(Color("textColor"))
            .font(.custom("MontserratRoman-Regular", size: 17))
            .padding()
    }
    
    @ViewBuilder
    func ChangeTab() -> some View {
        TextStyle(text: "Pick new icon")
//        textField(title: "Quest Icon", text: $icon)
        
        TextStyle(text: "Enter quest name")
        textField(title: "WriteName", text: $name)
        
        TextStyle(text: "update the new details of the quest")
        TextEditorDeteils()
    }
    
    func CharactAndPoints() -> some View {
        List {
            ForEach(char, id: \.self) { char in
                
                        HStack {
                            Text(char.name)
                                .lineLimit(2)
                            Spacer()
                            Button {
                                
                                
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    .onMove { indices, destination in
                        // TODO: update items array accordingly
                    }
                }
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
    
    func CreateAndCancelButtons() -> some View {
        HStack{
            CreateButton(label: "Create") {
                
            }
            CreateButton(label: "Cancel") {
                GlobalDialog.shared.dialog = .none
            }
        }
    }
}




////////////////
///HELPERS
////////////////
struct CreateButton: View {
    let label: String
    let action: () -> Void
    
    var body: some View{
        Button {
            action()
        } label: {
            HStack{
                if label == "Create"{
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
            if label == "Create"{
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
