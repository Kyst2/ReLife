import Foundation
import SwiftUI
import MoreSwiftUI

struct MyGroupBox<Content>: View where Content: View {
    var header: String
    var content: () -> Content
    
    var body: some View {
        MyGroupBox2(headerView: {
            Text(header)
                .fixedSize()
        }, content)
    }
}

struct MyGroupBox2<Content, Header>: View where Content: View, Header: View {
    var headerView: () -> Header
    var content: () -> Content
    
    init(headerView: @escaping () -> Header, _ content: @escaping () -> Content) {
        self.content = content
        self.headerView = headerView
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
                
                headerView()
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
                headerView()
                    .padding(.horizontal, 25)
                
                Spacer()
            }
            
            Spacer()
        }
    }
}
