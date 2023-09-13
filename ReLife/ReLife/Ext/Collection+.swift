import Foundation

public extension Collection where Element: Equatable {
    func contains(_ element: Element) -> Bool {
        for item in self {
            if item == element {
                return true
            }
        }
        return false
    }
}
