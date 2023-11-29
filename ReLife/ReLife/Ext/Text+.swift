import Foundation
import SwiftUI
//import MoreSwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Font {
     static func moncerat(size: CGFloat) -> Font {
        Font.custom("MontserratRoman-Regular", size: size)
    }
}

extension Text {
    
    func myFont(size: CGFloat, textColor: TextColor?) -> Text {
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
