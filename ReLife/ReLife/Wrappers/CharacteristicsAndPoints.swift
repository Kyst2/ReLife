import Foundation

struct CharacteristicsAndPoints: Equatable , Identifiable {
    var id = UUID()
    
    let charac: Characteristic
    let points: Int
}
