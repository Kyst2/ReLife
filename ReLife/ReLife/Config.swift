import Foundation
import SwiftUI
import AsyncNinja
import Essentials
import AppCoreLight

class Config : NinjaContext.Main  {
    static let shared: Config = initSharedConfig()
    
    init(store: ConfigBackend) {
        
    }
}

////////////////////////
///HELPERS
///////////////////////

fileprivate func initSharedConfig() -> Config {
    let se: ServiceEnvironment = .Release
    let cud = ConfigUserDefaults(env: se)
    
    return Config(store: cud)
}
