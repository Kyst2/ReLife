import Foundation
import SwiftUI
import MoreSwiftUI

struct MyGroupBox<Content>: View where Content: View {
    var header: String
    var content: () -> Content
    
    init(header: String, _ content: @escaping () -> Content) {
        self.header = header
        self.content = content
    }
    
    var body: some View {
        content()
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.white.opacity(0.3) , lineWidth: 1)
                    .padding(8)
                    .mask(MaskView())
                    .overlay { HeaderView() }
            )
    }
    
    func MaskView() -> some View {
        VStack(spacing: 0){
            HStack(spacing: 0) {
                Spacer().frame(width: 20, height: 20)
                    .background(.white)
                
                Text(header)
                    .padding(.horizontal, 5)
                    .foregroundColor(.clear)
                    .background(.clear)
                    .fixedSize()
                
                Spacer()
                    .frame(height: 20)
                    .background(.white)
                    
            }
            
            Spacer().fillParent().background(.black)
        }
    }
    
    func HeaderView() -> some View {
        VStack {
            HStack {
                Text(header)
                    .padding(.horizontal, 25)
                    .fixedSize()
                
                Spacer()
            }
            
            Spacer()
        }
    }
}
