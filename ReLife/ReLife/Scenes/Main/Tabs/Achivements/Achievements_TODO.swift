/*

 */

import Foundation

struct Achievement: Hashable {
    let icon: String?
    let title: String
    let descr: String
    let type: AchievementType
    
    let finished: Bool
    let date = Date.now
}

enum AchievementEnum: CaseIterable {
    case newbie
    case stressFighter
    case cleanTooth1, cleanTooth2, cleanTooth3, cleanTooth4
    case bestSleeper1, bestSleeper3, bestSleeper4, bestSleeper5//, bestSleeper2
    case mommysCleaner1, mommysCleaner2, mommysCleaner3, mommysCleaner4
    case vagina1, vagina2, vagina3, vagina4
    case proctolog1, proctolog2
    case healthCatcher1, healthCatcher2, healthCatcher3, healthCatcher4
}


extension AchievementEnum {
    func asAchievement() -> Achievement {
        var icon: String?
        var title: String = ""
        var descr: String = ""
        var type: AchievementType = .wood
        
        switch self {
        case .newbie:
            icon = "studentdesk" // 􀑔
            title = "Новачок"
            descr = "Виконав всі квести призначені на 1 день"
        
        
        case .stressFighter:
            icon = "figure.fall" // 􀵮
            title = "Стресостікість"
            descr = """
                    * Пережити похід до стоматолога
                    * Треба не забути нагородити себе нямкою!
                    """
            
        case .cleanTooth1:
            icon = "wind.snow" // 􀇦
            title = "Свіже дихання"
            descr = "Виконав квест \"чистить зуби\" 30 днів підряд"
        case .cleanTooth2:
            icon = "sparkle" // 􀫸
            title = "Нагорода \"Ліпші ікла на районі\""
            descr = """
                    * Виконав квест \"чистить зуби\" 30 днів підряд"
                    * 1 рази навідався до стоматолога за останні 200 днів
                    """
            type = .silver
        case .cleanTooth3:
            icon = "sparkles" // 􀆿
            title = "Нагорода \"Золоті ікла року\""
            descr = """
                    * Чистиш зуби 365 днів підряд
                    * 2 рази навідався до стоматолога за 365 днів
                    """
            type = .gold
        case .cleanTooth4:
            icon = "tornado" // 􀇧
            title = "Вертів я того стоматолога!"
            descr = """
                    * Чистиш зуби 730 днів підряд
                    * 4 рази навідався до стоматолога за 800 днів
                    """
            type = .gold
            
            
        case .bestSleeper1:
            icon = "zzz" // 􀖃
            title = "Це лише початок шляху до режиму сну!"
            descr = """
                    Квест "Йду спати вчасно" виконаний 14 днів підряд
                    """
//        case .bestSleeper2: // not implemented
        case .bestSleeper3:
            icon = "moon.zzz" // 􀆽
            title = "За межами людських можливостей!"
            descr = """
                    Квест "Йду спати вчасно" виконаний 365 днів підряд
                    """
            type = .gold
        case .bestSleeper4:
            icon = "bolt" // 􀋥
            title = "Гроза підкроватних монстрів"
            descr = """
                    Квест "Йду спати вчасно" виконаний 500 днів підряд
                    """
            type = .gold
        case .bestSleeper5:
            icon = "lizard.fill" // 􁗜
            title = "Я в ліжку - монстр!"
            descr = """
                    Квест "Йду спати вчасно" виконаний 730 днів підряд
                    """
            type = .gold
            
            
        case .mommysCleaner1:
            icon = "medal" // 􁏋
            title = "Медаль з картопельки \"Мамина чистюля\""
            descr = """
                    Прибирання раз на день не менше ніж 2 тижні підряд
                    """
        case .mommysCleaner2:
            icon = "sparkle" // 􀫸
            title = "Так чисто в квартирі ще не було!"
            descr = """
                    Прибирання раз на день не менше ніж 8 тижнів підряд
                    """
            type = .silver
        case .mommysCleaner3:
            icon = "sparkles" // 􀆿
            title = "Нагорода \"Неначе в операційній\""
            descr = """
                    Прибирання раз на день не менше ніж 365 днів підряд
                    """
            type = .gold
        case .mommysCleaner4:
            icon = "brain" // 􀯐
            title = "Бог чистоплотності"
            descr = """
                    Прибирання раз на день не менше ніж 730 днів підряд
                    """
            type = .gold
        
            
        case .vagina1:
            icon = "arrowshape.right" // 􁉂
            title = "Я у мами розумничка!"
            descr = """
                    1 плановий візит до гінеколога
                    """
        case .vagina2:
            icon  = "sunglasses" // 􁻈
            title = "Догляд за інтимним здоров'ям"
            descr = """
                    2 планових візитів до гінеколога(раз на пів року)
                    """
            type = .silver
        case .vagina3:
            icon  = "magnifyingglass" // 􀊫
            title = "Найдоглянутіша піхва на дикому заході"
            descr = """
                    6 планових візитів до гінеколога(раз на пів року)
                    """
            type = .gold
            
        case .vagina4:
            icon  = "brain" // 􀯐
            title = "Богиня інтимної охайності та здоров'я"
            descr = """
                    12 планових візитів до гінеколога(раз на пів року)
                    """
            type = .gold
            
        case .proctolog1:
            icon  = nil
            title = "Я не пальцем роблений!"
            descr = """
                    * Чоловік
                    * Старше 30 років
                    * Перший плановий похід до проктолога
                    """
            type = .silver
        case .proctolog2:
            icon  = nil
            title = "Нагорода \"Спелеолог десятиліття\" за найретельніше дослідження печери"
            descr = """
                    * Чоловік
                    * Старше 30 років
                    * Відбулись 4 планових походи до проктолога
                    """
            type = .gold
            
        case .healthCatcher1:
            icon  = "cross" //􀣜
            title = "Бронзовий збирач здоров'я"
            descr = """
                    * Здобув 500 очок характеристики "здоров'я"
                    """
            type = .wood
        case .healthCatcher2:
            icon  = "cross.fill" //􀣝
            title = "Срібний збирач здоров'я"
            descr = """
                    * Здобув 3_000 очок характеристики "здоров'я"
                    """
            type = .silver
        case .healthCatcher3:
            icon  = "staroflife" //􀑆
            title = "Золотий збирач здоров'я"
            descr = """
                    * Здобув 6_000 очок характеристики "здоров'я"
                    """
            type = .gold
        case .healthCatcher4:
            icon  = "staroflife.fill" //􀑇
            title = "Я що, житиму вічно?"
            descr = """
                    * Здобув 20_000 очок характеристики "здоров'я"
                    """
            type = .gold
        }
        
        return Achievement(icon: icon, title: title, descr: descr, type: type, finished: true )
    }
}
