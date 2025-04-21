import SwiftUI

struct StoresConfiguration: Codable, Equatable {
    let guestGreeting: String?
}

class StoresConfigurationState: ObservableObject {
    @Published private(set) var storesConfiguration: StoresConfiguration?
    
    private let storesConfigurationStore: StoresConfigurationStore
    
    init(storesConfigurationStore: StoresConfigurationStore) {
        self.storesConfigurationStore = storesConfigurationStore
    }
}

struct StoresConfigurationStore {
    
}

struct AppState {
    let sessionStore: SessionStore
    let themeConfigurationStore: ThemeConfigurationStore
    let storesConfigurationStore: StoresConfigurationStore
    
    let themeConfigurationState: ThemeConfigurationState
    let storesConfigurationState: StoresConfigurationState
    
    
    let authStatus: AuthStatus
    
    init(sessionStore: SessionStore, themeConfigurationStore: ThemeConfigurationStore, storesConfigurationStore: StoresConfigurationStore) {
        self.sessionStore = sessionStore
        
        self.themeConfigurationStore = themeConfigurationStore
        self.storesConfigurationStore = storesConfigurationStore
        
        self.themeConfigurationState = ThemeConfigurationState(themeConfigurationStore: themeConfigurationStore)
        self.storesConfigurationState = StoresConfigurationState(storesConfigurationStore: storesConfigurationStore)
        
        self.authStatus = AuthStatus(sessionStore: sessionStore)
       
    }
}

protocol KeyStore {
    func set(value: Any, for key: String) -> Void
    func get(_ key: String)-> Any?
    func clearValue(for key: String) -> Void
}

struct DefaultKeyStore: KeyStore {
    func get(_ key: String) -> Any? {
        UserDefaults.standard.object(forKey: key)
    }
    
    func set(value: Any, for key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func clearValue(for key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}



extension EnvironmentValues {
    var dependencies: DependencyContainer {
        get { self[DependencyContainer.self] }
        set { self[DependencyContainer.self] = newValue }
    }
}
