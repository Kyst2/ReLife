import SwiftUI
import MoreSwiftUI

class GlobalDialog: ObservableObject {
    static var shared = GlobalDialog()
    
    @Published var dialog: SheetDialogType = .none
    
    private init() {}
}
