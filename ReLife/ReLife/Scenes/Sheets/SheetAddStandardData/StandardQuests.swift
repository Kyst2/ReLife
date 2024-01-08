import Foundation

enum StandardCharach: String, CaseIterable {
    case health         = "charach_health"
    case tideness       = "charach_tideness"
    case atleticism     = "charach_althleticism"
    case mind           = "charach_mind"
}

extension StandardCharach {
    var icon: CharachIcon {
        switch self {
        case .health:
            return .health
        case .tideness:
            return .laurelR
        case .mind:
            return .brain
        case .atleticism:
            return .atleticism
        }
    }
    
    var title: String {
        self.rawValue.localized
    }
}

enum StandardQuests: String, CaseIterable {
    case cleanTeeth                 = "quest.cleanTeeth"
    case dantistVisit               = "quest.dantistVisit"
    case cleanApartment             = "quest.cleanApartment"
    case learnSwift                 = "quest.learnSwift"
    case playLearnGuitar            = "quest.learnGuitar"
    case doPushups                  = "quest.sport"
    case drinkWater                 = "quest.drinkWater"
    case washHair                   = "quest.washHair"
    
    case wGinecolog                 = "quest.ginecolog"
    case wGinecologDetailed         = "quest.ginecologDetailed"
    
    //case mProctolog               = "quest.proctolog"
    //case mProctologDetailed       = "quest.proctologDetailed"
    
    //case abdominalMassage         = "quest.abdominalMassage"
    //case faceFitness              = "quest.faceFitness"
    //case eyeFitness               = "quest.eyeFitness"
    //case callYourParents          = "quest.callYourParents"
    //case tikTokVideo              = "quest.tikTokVideo"
    //case goToSleepAtTime          = "quest.goSleep"
    //case socialMediaLess1hrDay    = "quest.socialMediaLess1hrDay"
    //case readBook                 = "quest.readBook" //min 50 pages
    //case checkWeight              = "quest.checkWeight"
    //case
    //case
    //case 
}



extension StandardQuests {
    var title: String {
        self.rawValue.localized
    }
    
    var icon: QuestIcon {
        switch self {
        case .cleanTeeth:
            return .paintBrush
        case .dantistVisit:
            return .stethoscope
        case .cleanApartment:
            return .house
        case .learnSwift:
            return .book
        case .playLearnGuitar:
            return .guitars
        case .doPushups:
            return .dumbell
        case .wGinecolog:
            return .stethoscope
        case .wGinecologDetailed:
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
        case .wGinecolog:
            return QuestRepeatType.repeatEvery(days: 180, startingFrom: Date.now.adding(days: -1) )
        case .wGinecologDetailed:
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
        case .wGinecolog:
            return 1
        case .wGinecologDetailed:
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
        case .wGinecolog:
            data = [
                (StandardCharach.health, 100),
                (StandardCharach.tideness, 100)
            ]
        case .wGinecologDetailed:
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
                     descr: self.descr
                    )
    }
}
