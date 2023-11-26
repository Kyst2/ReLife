import Foundation
import SwiftUI
//import MoreSwiftUI

extension Text {
    
    func myFont(size: CGFloat) -> Text{
         self.font(.custom("MontserratRoman-Regular", size: size))
    }
    
    func myColorBlue() -> Text {
        return self.foregroundColor(Color("textColor"))
    }
    func myColorWhite() -> Text {
        self.foregroundColor(Color("iconColor"))
    }
}
