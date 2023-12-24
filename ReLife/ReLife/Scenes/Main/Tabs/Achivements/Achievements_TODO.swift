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
    case bestSleeper1, bestSleeper3, bestSleeper4//, bestSleeper2
    case mommysCleaner1, mommysCleaner2, mommysCleaner3, mommysCleaner4
    case vagina1, vagina2, vagina3, vagina4
    case proctolog1, proctolog2
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
            icon = "bed.double" // 􀙩
            title = "Це лише початок шляху до режиму сну!"
            descr = """
                    Квест "Йду спати вчасно" виконаний 14 днів підряд
                    """
//        case .bestSleeper2: // not implemented
        case .bestSleeper3:
            icon = "zzz" // 􀖃
            title = "За межами людських можливостей!"
            descr = """
                    Квест "Йду спати вчасно" виконаний 365 днів підряд
                    """
            type = .gold
        case .bestSleeper4:
            icon = "moon.zzz" // 􀆽
            title = "Я єсьм бог сну!"
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
                    1 раз сходити на планове обстеження до гінеколога
                    """
        case .vagina2:
            icon  = "sunglasses" // 􁻈
            title = "Догляд за інтимним здоров'ям"
            descr = """
                    2 рази сходити на планове обстеження до гінеколога
                    """
            type = .silver
        case .vagina3:
            icon  = "magnifyingglass" // 􀊫
            title = "Найдоглянутіша піхва на дикому заході"
            descr = """
                    Ходиш до гінеколога 3 роки підряд не менше ніж раз на пів року
                    """
            type = .gold
            
        case .vagina4:
            icon  = "brain" // 􀯐
            title = "Богиня інтимної охайності та здоров'я"
            descr = """
                    Сходила до гінеколога 6 років підряд не менше ніж раз на пів року
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
        }
        
        return Achievement(icon: icon, title: title, descr: descr, type: type, finished: true )
    }
}
