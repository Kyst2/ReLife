import SwiftUI
import MoreSwiftUI

struct SettingsView: View {
    @State var isQuest: Bool = true
    var body: some View {
        VStack(spacing: 10){
            ButtonTab()
            
            QuestsSettings()
            
            AddQuestOrCharacteristics()
        }
    }
}
extension SettingsView {
    func ButtonTab() -> some View {
        HStack{
            Space(2)
            MenuButtons(lebel: "Quests") {
                isQuest = true
            }.background{
                 isQuest ? Color.gray.opacity(0.5) : Color.clear
            }
            Space(0)
            MenuButtons(lebel: "Characteristics") {
                isQuest = false
            }.background{
                !isQuest ? Color.gray.opacity(0.5) : Color.clear
           }
            Space(2)
        }
    }
    
    func QuestsSettings() -> some View {
        ScrollView{
            
        }
    }
    
    func AddQuestOrCharacteristics() -> some View {
        HStack(alignment: .top){
            Spacer()
            if isQuest == true {
                AddButton(lebel: "Quest") {
                    
                }
            }else {
                AddButton(lebel: "Characteristic") {
                    
                }
            }
           Space(10)
        }
    }
}






/////////////////
///HELPERS
/////////////////
struct AddButton: View {
    let lebel: String
    let action: () -> Void
    var body: some View{
        Button {
            action()
        } label: {
            HStack{
                Image(systemName: "plus")
                    .foregroundColor(Color("iconColor"))
                    .font(.largeTitle)
                
                Text(lebel)
                    .foregroundColor(Color("textColor"))
                    .font(.custom("MontserratRoman-Regular", size: 20))
                    
            }
        }
        .buttonStyle(.plain)
        .frame(width: 400,height: 40)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color("blurColor")).opacity(0.8)
            
        }
        .padding(20)
        
        .fixedSize()
        .frame(maxWidth: .infinity)
        
    }
}

struct MenuButtons: View {
    let lebel: String
    let action: () -> Void
    var body: some View {
        Button {
            withAnimation(.easeIn(duration: 0.2 )){
                action()
            }
        } label: {
            Text(lebel)
                .foregroundColor(Color("textColor"))
                .font(.custom("MontserratRoman-Regular", size: 18))
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.primary, lineWidth: 0.1)
        }
    }
}
