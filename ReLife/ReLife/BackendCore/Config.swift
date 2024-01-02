import Foundation
import SwiftUI
import AsyncNinja
import Essentials
import AppCoreLight

class Config : NinjaContext.Main  {
    static let shared: Config = initSharedConfig()
    
    var preludePassed : ConfigProperty<Bool>
    
    var achievementsEnabled         : ConfigProperty<Bool>
    var isMale                      : ConfigProperty<Bool>
    var birthDay                    : ConfigProperty<Date>
    var achievementsEvilEnabled     : ConfigProperty<Bool>
    
    let soundEnabled                : ConfigProperty<Bool>
    let soundVolume                : ConfigProperty<Float>
    
    init(store: ConfigBackend) {
//        store.clear()
        preludePassed           = store.property(key: "preludePassed", defaultValue: false )
        
        achievementsEnabled     = store.property(key: "achievementsEnabled", defaultValue: true )
        achievementsEvilEnabled = store.property(key: "achievementsEvilEnabled", defaultValue: true )
        isMale                  = store.property(key: "achievementsIsMale", defaultValue: true )
        birthDay                = store.property(key: "achievementsBirthDay", defaultValue: Date.now )
        
        soundEnabled            = store.property(key: "soundEnabled", defaultValue: true )
        soundVolume             = store.property(key: "soundVolume", defaultValue: 0.6 )
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
