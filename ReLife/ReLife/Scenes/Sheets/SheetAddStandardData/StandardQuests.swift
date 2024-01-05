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
//    case cleanApartment = "quest.cleanApartment"
//    case learnSwift   = "quest.learnSwift"
//    case playLearnGuitar   = "quest.learnGuitar"
//    case doPushups   = "quest.pushups"
//    case ginecolog = "quest.ginecolog"
//    case ginecologDetailed = "quest.ginecologDetailed"
//    case drinkWater = "quest.drinkWater"
//    case washHair = "quest.washHair"
}



extension StandardQuests {
    var title: String {
        self.rawValue.localized
    }
    
    var icon: QuestIcon {
        switch self {
        case .cleanTeeth:
            return .forkKnife
        case .dantistVisit:
            return .backpack
        }
    }
    
    var repeatType: QuestRepeatType {
        switch self {
        case .cleanTeeth:
            return QuestRepeatType.eachWeek(days: [1,2,3,4,5,6,7])
        case .dantistVisit:
            //first day of current year - fix me!!!!
            return QuestRepeatType.repeatEvery(days: 360/2, startingFrom: Date.now.adding(days: -Date.now.day))
        }
    }
    
    var repeatsPerDay: Int {
        switch self {
        case .cleanTeeth:
            return 2
        case .dantistVisit:
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
