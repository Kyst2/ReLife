import SwiftUI
import MoreSwiftUI

struct CharacteristicsAndPointsListView: View {
    @Binding var charAndPoints: [CharacteristicsAndPoints]
    
    var body: some View {
        GroupBox{
            ScrollView {
                VStack(spacing: 10){
                    ForEach(charAndPoints) { pair in
                        HStack {
                            Text(pair.charac.name)
                            
                            Spacer()
                            
                            NumUpDown(allPairs: $charAndPoints, thisPair: pair)
                        }
                    }
                }
            }
            .frame(height: 130)
            .padding(.horizontal, 15)
        }
    }
}
