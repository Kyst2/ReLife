import SwiftUI
import MoreSwiftUI

struct NumUpDown: View {
    @State private var isHovered: Bool = false
    
    @Binding var allPairs: [CharacteristicsAndPoints]
    
    public let thisPair: CharacteristicsAndPoints
    @State var isEditing = false
    
    var body: some View {
        let points = Array(0...10).map{ $0 * 5 }
        
        PopoverButt(edge: .leading, isPresented: $isEditing, TrueBody) {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(points, id: \.self) { currPoints in
                        Text("\(currPoints)")
                            .onTapGesture {
                                guard let idx = allPairs.firstIndex(of: thisPair) else { return }
                                
                                allPairs[idx] = CharacteristicsAndPoints(id: thisPair.id, charac: thisPair.charac, points: currPoints)
                                
                                isEditing = false
                            }
                    }
                }
            }
            .padding( EdgeInsets(horizontal: 20, vertical: 10) )
        }
    }
    
    func TrueBody() -> some View {
        HStack {
            Text("\(thisPair.points)")
        }
        .opacity(isHovered ? 1 : 0.8)
        .onHover{ hvr in withAnimation { self.isHovered = hvr } }
    }
}
