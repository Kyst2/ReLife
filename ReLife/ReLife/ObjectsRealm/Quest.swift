import Foundation
import RealmSwift
import AppKit

public class Quest: Object {
    @Persisted(primaryKey: true) var key: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var charachPoints = Map<String, Int>()
    @Persisted private var iconStr: String
    @Persisted var colorHex: List<Float>
    @Persisted private var questRepeatStr: String
    
    var questRepeat: QuestRepeatType { get { QuestRepeatType.fromString(questRepeatStr) } set { questRepeatStr = newValue.toString() } }
    var icon: MyIcon { get { MyIcon(rawValue: self.iconStr)! } set { self.iconStr = newValue.rawValue } }
    
    override init() {
        self.name = ""
        self.iconStr = MyIcon.americanFootball.rawValue
    }
    
    convenience init(name: String, icon: MyIcon, color: NSColor, charachPoints : Dictionary<Characteristic, Int>,questRepeatStr: QuestRepeatType) {
        self.init()
        self.name = name
        self.iconStr = icon.rawValue
        self.colorHex.append(objectsIn: color.hexValues)
        self.questRepeatStr = questRepeatStr.toString()
        
        charachPoints.forEach {
            self.charachPoints.setValue($0.value, forKey: $0.key.key)
        }
    }
}

//https://github.com/realm/realm-swift/issues/2755
enum QuestType {
    case timed(sec: Int)
    case ml(ml: Int)
}

enum QuestRepeatType: Codable {
    case singleDayQuest(date: Date)
    case eachWeek(days: [Int])
    case dayOfMonth(days: [Int])
    case repeatEvery(days: Int, startingFrom: Date)
}

extension QuestRepeatType: Equatable { }

extension QuestRepeatType {
    func toString() -> String {
        return (try? self.asJson().get()) ?? ""
    }
    
    static func fromString(_ str: String ) -> QuestRepeatType {
        return (try? str.decodeFromJson(type: QuestRepeatType.self).get() ) ?? .eachWeek(days: [])
    }
}

public extension NSColor {
    var hexValues: [Float] {
        guard let fixedColor = self.usingColorSpace(.sRGB) else { return [] }
        
        let a = [Float(fixedColor.redComponent), Float(fixedColor.greenComponent), Float(fixedColor.blueComponent)]
        
        return a
    }
    
    convenience init(hexValues: [Float]) {
        self.init(red: hexValues[0].cgFloat, green: hexValues[1].cgFloat, blue: hexValues[2].cgFloat, alpha: 1)
    }
}

public extension Float {
    var cgFloat: CGFloat {
        CGFloat(self)
    }
}

public extension List  where Element : RealmCollectionValue, Element == Float {
    func asNSColor() -> NSColor {
        NSColor(hexValues: Array(self))
    }
}



enum MyIcon: String, RawRepresentable {
    case tray = "tray.2.fill"
    case charBook = "character.book.closed.fill"
    case pencilAndRule = "pencil.and.ruler"
    case backpack = "backpack.fill"
    case studentDesc = "studentdesk"
    case personWave = "person.wave.2.fill"
    case pesron3 =  "person.3.fill"
    case figureWalk = "figure.walk"
    case childHolidonhands = "figure.2.and.child.holdinghands"
    case americanFootball = "figure.american.football"
    case skiing = "figure.skiing.downhill"
    case mindAndBody = "figure.mind.and.body"
    case waterFitness = "figure.water.fitness"
    case dumbell = "dumbbell.fill"
    case soccerball = "soccerball.inverse"
    case baseball = "baseball.fill"
    case tennisRacket = "tennis.racket"
    case circleHand = "dot.circle.and.hand.point.up.left.fill"
    case globe = "globe"
    case moon = "moon.fill"
    case beachUmbrella = "beach.umbrella.fill"
    case mic = "mic.fill"
    case star = "star.fill"
    case bolt = "bolt.fill"
    case camera = "camera.fill"
    case phone = "phone.arrow.up.right.circle.fill"
    case video =  "video.circle.fill"
    case envelope = "envelope.circle.fill"
    case geraShape = "gearshape.fill"
    case cartCircle = "cart.circle.fill"
    case screwDrive = "screwdriver.fill"
    case stethoscope = "stethoscope.circle.fill"
    case crossCase = "cross.case.fill"
    case bathtub = "bathtub.fill"
    case partyPopper = "party.popper.fill"
    case sink = "sink.fill"
    case bicycle = "bicycle.circle.fill"
    case playstation = "playstation.logo"
    case forkKnife = "fork.knife.circle.fill"
    case giftCircle = "gift.circle.fill"
    case batteryFull = "battery.100.circle.fill"
    case function = "function"
    case waveform = "waveform.circle"
    case cupSaucer = "cup.and.saucer.fill"
    case fish = "fish.fill"
    case pillsCircle = "pills.circle.fill"
}
