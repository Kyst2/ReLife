import Foundation

enum StandardQuests: String, CaseIterable {
    case cleanTeeth   = "quest.cleanTeeth"
    case dantistVisit = "quest.dantistVisit"
}

extension StandardQuests {
    var title: String {
        self.rawValue.localized
    }
    
    var icon: MyIcon {
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
}

extension StandardQuests {
    func asQuest(characteristics: [Characteristic]) -> Quest {
        let charachAndPoints: Dictionary<Characteristic, Int> = [:] // fill me
        
        return Quest(name: self.title,
                      icon: self.icon,
                      color: RLColors.brown.nsColor,
                      charachPoints: charachAndPoints,
                      questRepeatStr: self.repeatType,
                      repeatTimes: self.repeatsPerDay,
                      descript: self.descr
                    )
    }
}
