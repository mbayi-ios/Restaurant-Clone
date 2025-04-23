import SwiftUI

import SwiftUI
import Combine

struct DependencyContainer: EnvironmentKey {
    let tasks: Tasks
    let state: AppState
    
    static var defaultValue: Self { Self.default}
    
    private static var `default` : Self = {
        let keyStore = DefaultKeyStore()
        let sessionStore = SessionStore(keyStore: keyStore)
        let context = NovadineMessageContext(sessionStore: sessionStore)
        let client = HTTPClient(context: context)
        let themeConfigurationStore = ThemeConfigurationStore()
        let storesConfigurationStore = StoresConfigurationStore()
        
        let repositories = Repositories()
        
        repositories.register(ThemeConfigurationRepository(client: client, store: themeConfigurationStore))
        repositories.register(CustomerRepository(client: client, sessionStore: sessionStore))
        
        return Self(
            tasks: Tasks(repositories: repositories),
            state: AppState(sessionStore: sessionStore,
                            themeConfigurationStore: themeConfigurationStore,
                            storesConfigurationStore: storesConfigurationStore)
        )
    }()
    
}


extension EnvironmentValues {
    var dependencies: DependencyContainer {
        get { self[DependencyContainer.self] }
        set { self[DependencyContainer.self] = newValue }
    }
}
