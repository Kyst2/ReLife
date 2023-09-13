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
//func Quest
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
            }
        }
    }
}
//func Characteristic
extension RealmController {
    func add(characteristic: Characteristic) {
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
    
    func update(characteristicKey: String, withValues: Characteristic) {
        if let characteristic = realm.object(ofType: Characteristic.self, forPrimaryKey: characteristicKey) {
            try! realm.write {
                characteristic.name = withValues.name
                
            }
        }
    }
}
//func History
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
                
                return date == today ? quest : nil
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
                
                // TODO: make Date+ ext: date1.distance(to: date2, type: .day) -> Int
                let daysSinceStart = Calendar.current.dateComponents([.day], from: dateStart, to: today).day ?? 0
                
                return ((daysSinceStart % repeatEachDays) == 0) ? quest : nil
            }
            .compactMap { $0 }
        
        allQuestsToday.append(repeatEvery)
        
        return allQuestsToday.flatMap{ $0 }
        
        //витягування актуальних задач на сьогоднішній день (окрім виконаних) - окрема функции которая использует эту
//        витягування виконаних задач на сьогоднішній день(окрім актуальних)- окрема функции которая использует эту
    }
    
    func getActualQuestsToday() -> [Quest]?{
        let actualQuests = getQuestsToday()
        
        return actualQuests?.map({ quest -> Quest? in
            if !allHistory.contains(where: { history in
                (history.quest?.name.contains(quest.name))!
            }){
                return quest
            }else {
                return nil
            }
        })
        .compactMap{ $0 }
    }
    func getSingleQuestHalfYear() -> [Quest]? {
        let allQuests = questsAll
        let allHistory = allHistory
        
        let singleDayQuests = allQuests.map { quest -> Quest? in


            guard case let .singleDayQuest(date) = quest.questRepeat,date <= Date.now.adding(days: 182),
                 !allHistory.contains(where: { history in
                (history.quest?.name.contains(quest.name))!
            })
            else { return nil }
            
            
            return quest
        }
            .compactMap{ $0 }
        
        return singleDayQuests
    }
}

//TODO NOW:
// * витягування невиконаних разових задач на найближчі пів року
// * витягнути з історії зароблену к-сть балів на конкретну характеристику
// * Знімати бали за невиконаний квест (галочка) - додати в квест і написати тест

enum QuestFinishType: Codable {
    case mililitres
    case timesRepeat
    case timer(sec: Int)
}

//func questNeedToDoTimes(_ quest: Quest) -> Int {
//
//}
