import Foundation

struct CharacteristicsAndPoints: Equatable , Identifiable {
    let id = UUID()
    
    let charac: Characteristic
    var points: Int
}
