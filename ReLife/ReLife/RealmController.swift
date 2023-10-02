import Foundation
import RealmSwift

public class RealmController {
    var realm: Realm
    
    var questsAll: [Quest] { realm.objects(Quest.self).map{ $0 } }
    var characteristicsAll: [Characteristic] { realm.objects(Characteristic.self).map{ $0 } }
    var allHistory: [History] { realm.objects(History.self).map{ $0 } }
    
    public init(test: Bool = false) {
        
        let config = test
        ? Realm.Configuration(fileURL: URL.applicationDirectory.appendingPathComponent("realmTest.realm") ,inMemoryIdentifier: "testRealm")
                        : Realm.Configuration(encryptionKey: nil)
        
        let r = try? Realm(configuration: config)
        
        self.realm = r!
        
    }
   
}

extension RealmController {
    func add(quest: Quest) {
        try! realm.write {
            realm.add(quest)
        }
    }
    
    func remove(questKey: String) {
        if let quest = realm.object(ofType: Quest.self, forPrimaryKey: questKey) {
            try! realm.write {
                realm.delete(quest)
            }
        }
    }

    func update(questKey: String, withValues: Quest) {
        if let quest = realm.object(ofType: Quest.self, forPrimaryKey: questKey) {
            try! realm.write {
                quest.name = withValues.name
                quest.icon = withValues.icon
                quest.colorHex = withValues.colorHex
                quest.charachPoints = withValues.charachPoints
                quest.questRepeat = withValues.questRepeat
                quest.repeatTimes = withValues.repeatTimes
            }
        }
    }
}
//func Characteristic
extension RealmController {
    func add(characteristic: Characteristic) {
        guard characteristicsAll.filter({$0.name == characteristic.name}).count == 0 else { return }
        
        try! realm.write {
            realm.add(characteristic)
        }
    }
    
    func remove(characteristicKey: String) {
        if let characteristic = realm.object(ofType: Characteristic.self, forPrimaryKey: characteristicKey) {
            try! realm.write {
                realm.delete(characteristic)
            }
        }
    }
    
    func update(characteristicKey: String , withValues:Characteristic){
        if let oldCharacteristic = realm.object(ofType: Characteristic.self, forPrimaryKey: characteristicKey){
            try! realm.write {
                realm.delete(oldCharacteristic)
            }
        }
        try! realm.write{
            realm.add(withValues)
        }
    }

}
extension RealmController {
    func add(history: History) {
        try! realm.write {
            realm.add(history)
        }
    }
    
    func remove(historyKey: String) {
        if let history = realm.object(ofType: History.self, forPrimaryKey: historyKey) {
            try! realm.write {
                realm.delete(history)
            }
        }
    }
}

extension RealmController {
    
    func getQuestsToday(dateNow today: Date = Date.now) -> [Quest]?{
        let allQuests = self.questsAll
        let todayDayNumOfWeek = today.dayNumOfWeek() ?? 0
        let todayDayNumOfMonth = today.dayNumOfMonth() ?? 0
        
        var allQuestsToday: [[Quest]] = []
        
        let singleDate = allQuests
            .map { quest -> Quest? in
                guard case let .singleDayQuest(date) = quest.questRepeat else { return nil }
                
                return date.dateWithoutTime() == today.dateWithoutTime() ? quest : nil
            }
            .compactMap{ $0 }
        
        allQuestsToday.append(singleDate)
        
        let eachWeek = allQuests
            .map { quest -> Quest? in
                guard case let .eachWeek(days) = quest.questRepeat,
                      days.contains(todayDayNumOfWeek)
                else { return nil }
                
                return quest
            }
            .compactMap { $0 }
        
        allQuestsToday.append(eachWeek)
        
        let dayOfMonth = allQuests
            .map { quest -> Quest? in
                guard case let .dayOfMonth(days) = quest.questRepeat,
                      days.contains(todayDayNumOfMonth)
                else { return nil }
                
                return quest
            }
            .compactMap { $0 }
        
        allQuestsToday.append(dayOfMonth)
        
        let repeatEvery = allQuests
            .map { quest -> Quest? in
                guard case let .repeatEvery(repeatEachDays, dateStart) = quest.questRepeat,
                      dateStart <= today
                else { return nil }

                let daysSinceStart = dateStart.distance(to: today, type: .day)
                
                return ((daysSinceStart % repeatEachDays) == 0) ? quest : nil
            }
            .compactMap { $0 }
        
        allQuestsToday.append(repeatEvery)
        
        return allQuestsToday.flatMap{ $0 }
        
        //++++++  витягування актуальних задач на сьогоднішній день (окрім виконаних) - окрема функции которая использует эту
        //++++++  витягування виконаних задач на сьогоднішній день(окрім актуальних)- окрема функции которая использует эту
    }
    
    func getFinishedQuestsToday(dateNow: Date = Date.now) -> Dictionary<Quest,Int> {
        // здихатися квестсТудей
        let quests = allHistory.filter({$0.dateCompleted == dateNow.dateWithoutTime()})
            .compactMap { history -> Quest? in
                return history.quest
            }
        let questsAndCount = Dictionary(quests.map { ($0, 1) }, uniquingKeysWith: +)
        
        
        return questsAndCount
    }
 
    func getActualQuestsToday(dateNow: Date = Date.now) -> [Quest] {
        guard let questsToday = getQuestsToday(dateNow: dateNow) else { return [] }
        
        let historyObject = realm.objects(History.self)
        let historyFilter = historyObject.where({$0.dateCompleted == dateNow.dateWithoutTime()})
        
        let filterQuestsInHistory = questsToday.map { quest -> Quest? in
            if !historyFilter.contains(where: { history in
                (history.quest?.key.contains(quest.key))!
            }) {
                return quest
            } else {
                return nil
            }
        }
            .compactMap{ $0 }
        
        let questsAndCount = filterQuestsInHistory
            .asDict(groupedBy: { $0 } ) // [Quest: [Quest]]
            .mapValues { items in items.count } // [Quest : Count]
        
        let actualQuestsToday = questsAndCount.compactMap { (quest , count) -> Quest? in
            if count <= quest.repeatTimes {
                return quest
            }
            else {
                return nil
            }
        }
        
        return actualQuestsToday
    }
    
    func getSingleQuestHalfYear(dateNow: Date = Date.now) -> [Quest] {
        let allQuests = questsAll
        let allHistory = allHistory
        
        let singleDayQuests = allQuests.map { quest -> Quest? in
            guard case let .singleDayQuest(date) = quest.questRepeat,date <= dateNow.adding(days: 182),
                  !allHistory.contains(where: { history in
                      (history.quest?.name.contains(quest.name))!
                  })
            else { return nil }
            
            return quest
        }
            .compactMap{ $0 }
        
        return singleDayQuests
    }
    
    func getAllCharacteristicPoints() -> Dictionary<Characteristic, Int> {
        let characs = self.characteristicsAll
        
        var result = characs.asDictionary(key: \.self, block: { _ in 0 })
        
        allHistory
            .compactMap { $0.quest }
            .asDict(groupedBy: { $0 } ) // [Quest: [Quest]]
            .mapValues { items in items.count } // [Quest : Count]
            .forEach { args in
                let (quest, questFinishedTimes) = args
                
                quest.charachPoints
                    .compactMap { charac -> (charac: Characteristic, points: Int)? in
                        if let charac1 = characs.first(where: { $0.key == charac.key }) {
                            return (charac1, charac.value)
                        }
                        
                        return nil
                    }
                    .forEach { arg in
                        if let _ = result[arg.charac] {
                            result[arg.charac]! += arg.points * questFinishedTimes
                        }
                    }
            }
        
        return result
    }
    
    enum QuestFinishType: Codable {
        case mililitres
        case timesRepeat
        case timer(sec: Int)
    }
    
    //func questNeedToDoTimes(_ quest: Quest) -> Int {
    //
    //}
}

extension Sequence {
    func asDict(groupedBy: (Self.Element) -> Self.Element ) -> [ Self.Element : [Self.Element] ] where Self.Element: Hashable {
        Dictionary(grouping: self, by: groupedBy )
    }
}


public extension Sequence {
    func asDictionary<Key: Hashable, Value>(block: (Element)->(Value)) -> [Key:Value] where Key == Self.Element {
        self.asDictionary(key: \.self, block: block)
    }
    
    func asDictionary<Key: Hashable, Value>(key: KeyPath<Element, Key>, block: (Element)->(Value)) -> [Key:Value] {
        var dict: [Key:Value] = [:]
        
        for element in self {
            let key = element[keyPath: key]
            let value = block(element)
            
            dict[key] = value
        }
        
        return dict
    }
    
    
}
