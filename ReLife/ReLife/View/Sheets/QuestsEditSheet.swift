import SwiftUI
import MoreSwiftUI

struct QuestsEditSheet: View {
    @ObservedObject var quest: Questec
    @Binding var dialog: SheetDialogType
    var body: some View {
        VStack{
            TextField("Quest Name", text: $quest.name)
            TextField("Quest Icon", text: $quest.icon)
        }
    }
}
