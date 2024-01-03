#if os(macOS)

import SwiftUI
import AppKit

struct HapticMacOs {
    static func vibrate(_ pattern: NSHapticFeedbackManager.FeedbackPattern = .alignment) {
        NSHapticFeedbackManager.defaultPerformer.perform(pattern, performanceTime: .now)
    }
}

#endif
