import Foundation

enum StandardCharach: String {
    case health
    case tideness
    case atleticism
    case mind
}

enum StandardQuests: String, CaseIterable {
    case cleanTeeth   = "quest.cleanTeeth"
    case dantistVisit = "quest.dantistVisit"
    case cleanApartment = "quest.cleanApartment"
    case learnSwift   = "quest.learnSwift"
    case playLearnGuitar   = "quest.learnGuitar"
    case doPushups   = "quest.pushups"
    case ginecolog = "quest.ginecolog"
    case ginecologDetailed = "quest.ginecologDetailed"
    case drinkWater = "quest.drinkWater"
    case washHair = "quest.washHair"
}



extension StandardQuests {
    var title: String {
        self.rawValue.localized
    }
    
    var icon: QuestIcon {
        switch self {
        case .cleanTeeth:
            return .bathtub
        case .dantistVisit:
            return .stethoscope
        case .cleanApartment:
            return .paintBrush
        case .learnSwift:
            return .book
        case .playLearnGuitar:
            return .guitars
        case .doPushups:
            return .dumbell
        case .ginecolog:
            return .stethoscope
        case .ginecologDetailed:
            return .stethoscope
        case .drinkWater:
            return .waterDrop
        case.washHair:
            return .shower
        }
    }
    
    var repeatType: QuestRepeatType {
        switch self {
        case .cleanTeeth:
            return QuestRepeatType.eachWeek(days: [1,2,3,4,5,6,7])
        case .dantistVisit:
            //first day of current year - fix me!!!!
            return QuestRepeatType.repeatEvery(days: 360/2, startingFrom: Date.now.adding(days: -Date.now.day))
        case .cleanApartment:
            return QuestRepeatType.repeatEvery(days: 1, startingFrom: Date.now)
        case .learnSwift:
            return QuestRepeatType.repeatEvery(days: 1, startingFrom: Date.now)
        case .playLearnGuitar:
            return QuestRepeatType.eachWeek(days: [1,3,5])
        case .doPushups:
            return QuestRepeatType.eachWeek(days: [1,3,5])
        case .ginecolog:
            return QuestRepeatType.repeatEvery(days: 180, startingFrom: Date.now.adding(days: -1) )
        case .ginecologDetailed:
            return QuestRepeatType.repeatEvery(days: 360 * 3, startingFrom: Date.now.adding(days: -1) )
        case .drinkWater:
            return QuestRepeatType.repeatEvery(days: 1, startingFrom: Date.now)
        case .washHair:
            return QuestRepeatType.eachWeek(days: [5])
        }
    }
    
    var repeatsPerDay: Int {
        switch self {
        case .cleanTeeth:
            return 2
        case .dantistVisit:
            return 1
        case .cleanApartment:
            return 1
        case .learnSwift:
            return 3
        case .playLearnGuitar:
            return 1
        case .doPushups:
            return 1
        case .ginecolog:
            return 1
        case .ginecologDetailed:
            return 1
        case .drinkWater:
            return 3
        case .washHair:
            return 1
        }
    }
    
    var descr: String {
        let key = "\(self.rawValue).descr"
        let keyLocalized = key.localized
        
        return key == keyLocalized ? "" : keyLocalized
    }
    
    func genearateCharachPoints(from carhach: [Characteristic] ) -> Dictionary<Characteristic, Int> {
        var charachAndPoints: Dictionary<Characteristic, Int> = [:]
        
        var data: [(StandardCharach, Int)]
        
        switch self {
        case .cleanTeeth:
            data = [
                (StandardCharach.health, 15),
                (StandardCharach.tideness, 5)
            ]
        case .dantistVisit:
            data = [
                (StandardCharach.health, 100),
                (StandardCharach.tideness, 100)
            ]
        case .cleanApartment:
            data = [
                (StandardCharach.health, 100),
                (StandardCharach.tideness, 100)
            ]
        case .learnSwift:
            data = [
                (StandardCharach.health, 100),
                (StandardCharach.tideness, 100)
            ]
        case .playLearnGuitar:
            data = [
                (StandardCharach.health, 100),
                (StandardCharach.tideness, 100)
            ]
        case .doPushups:
            data = [
                (StandardCharach.health, 100),
                (StandardCharach.tideness, 100)
            ]
        case .ginecolog:
            data = [
                (StandardCharach.health, 100),
                (StandardCharach.tideness, 100)
            ]
        case .ginecologDetailed:
            data = [
                (StandardCharach.health, 100),
                (StandardCharach.tideness, 100)
            ]
        case .drinkWater:
            data = [
                (StandardCharach.health, 100),
                (StandardCharach.tideness, 100)
            ]
        case .washHair:
            data = [
                (StandardCharach.health, 100),
                (StandardCharach.tideness, 100)
            ]
        }
        
        data.forEach { pair in
            if let charach = carhach.filter({ $0.key == pair.0.rawValue }).first {
                charachAndPoints[charach] = pair.1
            }
        }
        
        return charachAndPoints
    }
}

extension StandardQuests {
    func asQuest(characteristics: [Characteristic]) -> Quest {
        return Quest(key: self.rawValue,
                     name: self.title,
                     icon: self.icon,
                     color: RLColors.brown.nsColor,
                     charachPoints: self.genearateCharachPoints(from: characteristics),
                     repeatType: self.repeatType,
                     repeatTimes: self.repeatsPerDay,
                     descript: self.descr
                    )
    }
}
