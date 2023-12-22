import Foundation
import SwiftUI
import MoreSwiftUI



extension Text {
    func applyTextStyle() -> some View {
        self
            .foregroundColor(Color("textColor"))
            .font(.custom("MontserratRoman-Regular", size: 13)).italic()
    }
}

extension TextField {
    func applyFieldStyle() -> some View {
        self
            .textFieldStyle(.roundedBorder)
            .font(.custom("MontserratRoman-Regular", size: 15))
    }
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}

public extension Text {
    static func sfIcon2( _ sysName: String, size: CGFloat) -> some View {
        return Image(systemName: sysName)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Font {
     static func moncerat(size: CGFloat) -> Font {
        Font.custom("MontserratRoman-Regular", size: size)
    }
}

extension Text {
    func myFont(size: CGFloat, textColor: TextColor? = nil) -> Text {
        if textColor == .blue {
            self.font(.custom("MontserratRoman-Regular", size: size))
                .foregroundColor(Color("textColor"))
        } else {
            self.font(.custom("MontserratRoman-Regular", size: size))
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
