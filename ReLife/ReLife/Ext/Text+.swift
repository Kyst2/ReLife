import Foundation
import SwiftUI
//import MoreSwiftUI

extension Text {
    
    func myFont(size: CGFloat,textColor: TextColor) -> Text {
        if textColor == .blue {
            self.font(.custom("MontserratRoman-Regular", size: size))
                .foregroundColor(Color("textColor"))
        } else {
            self.font(.custom("MontserratRoman-Regular", size: size))
                .foregroundColor(Color("iconColor"))
        }
    }
    
    func myColorBlue() -> Text {
        return self.foregroundColor(Color("textColor"))
    }
    func myColorWhite() -> Text {
        self.foregroundColor(Color("iconColor"))
    }
}


enum TextColor {
    case blue
    case white
}
