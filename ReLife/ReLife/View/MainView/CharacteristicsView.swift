//
//  CharacteristicsView.swift
//  ReLife
//
//  Created by Andrew Kuzmich on 09.10.2023.
//

import SwiftUI

struct CharacteristicsView: View {
    var body: some View {
        
            CharacterView()
        
    }
}
func CharacterView() -> some View {
    ScrollView{
        ForEach(char.sorted {$0.name > $1.name}, id: \.self) { char in
            //        let char = char[index]
            Charact(name: char.name, icon: char.icon, points: char.points)
        }
    }
}
struct Charact: View {
    var name: String
    var icon:String
    var points:Int
    var body: some View {
        HStack{
            Image(systemName: icon)
                .foregroundColor(Color("textColor"))
                .font(.largeTitle)
            
            Text(name)
                .font(.headline)
            
            Spacer()
            
            Text("\(points)")
                .padding(.trailing,20)
        }.padding()
            .overlay {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.primary, lineWidth: 0.1)
            }
    }
}
struct CharacteristicsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacteristicsView()
    }
}


class Characteristics1: Hashable {
    var name: String
    var icon:String
    var points: Int
    func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(icon)
            hasher.combine(points)
        }
    init(name: String, icon: String, points: Int) {
        self.name = name
        self.icon = icon
        self.points = points
    }
}
var char = [Characteristics1(name: "Health", icon: "heart.fill", points: 15),Characteristics1(name: "Strength", icon: "heart.fill", points: 50),Characteristics1(name: "Cleaner", icon: "heart.fill", points: 30)]
extension Characteristics1: Equatable {
    static func == (lhs: Characteristics1, rhs: Characteristics1) -> Bool {
        return lhs.name == rhs.name
    }
}
