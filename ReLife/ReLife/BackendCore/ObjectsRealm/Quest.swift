import Foundation
import RealmSwift
#if os(macOS)
import AppKit
#endif

public class Quest: Object, Identifiable {
    @Persisted(primaryKey: true) var key: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var charachPoints = Map<String, Int>()
    @Persisted private var iconStr: String
    @Persisted var colorHex: List<Float>
    @Persisted private var questRepeatStr: String
    @Persisted var repeatTimes: Int
    @Persisted var descr: String
    
    var isStandardQuest: Bool {
        return StandardQuests(rawValue: self.key) != nil
    }
    
    var questRepeat: QuestRepeatType { get { QuestRepeatType.fromString(questRepeatStr) } set { questRepeatStr = newValue.toString() } }
    var icon: QuestIcon { get { QuestIcon(rawValue: self.iconStr) ?? QuestIcon.bathtub  } set { self.iconStr = newValue.rawValue } }
    
    
    override init() {
        super.init()
        self.name = ""
        self.iconStr = QuestIcon.americanFootball.rawValue
    }
    
    convenience init(key: String, name: String, icon: QuestIcon, color: NSColor, charachPoints : Dictionary<Characteristic, Int>, repeatType: QuestRepeatType, repeatTimes: Int = 1, descr: String = "") {
        self.init()
        self.key = key
        self.name = name
        self.iconStr = icon.rawValue
        self.colorHex.append(objectsIn: color.hexValues)
        self.questRepeatStr = repeatType.toString()
        self.repeatTimes = repeatTimes
        charachPoints.forEach {
            self.charachPoints.setValue($0.value, forKey: $0.key.key)
        }
        self.descr = descr
    }
    
    convenience init(name: String, icon: QuestIcon, color: NSColor, charachPoints : Dictionary<Characteristic, Int>, repeatType: QuestRepeatType, repeatTimes: Int = 1, descr: String = "") {
        self.init()
        self.name = name
        self.iconStr = icon.rawValue
        self.colorHex.append(objectsIn: color.hexValues)
        self.questRepeatStr = repeatType.toString()
        self.repeatTimes = repeatTimes
        charachPoints.forEach {
            self.charachPoints.setValue($0.value, forKey: $0.key.key)
        }
        self.descr = descr
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

