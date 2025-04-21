import SwiftUI
import Combine

struct DependencyContainer: EnvironmentKey {
    let tasks: Tasks
    let state: AppState
    
    static var defaultValue: Self { Self.default}
    
    private static var `default` : Self = {
        let keyStore = DefaultKeyStore()
        let sessionStore = SessionStore(keyStore: keyStore)
        let context = NovadineMessageContext()
        let client = HTTPClient(context: context)
        let themeConfigurationStore = ThemeConfigurationStore()
        
        let repositories = Repositories()
        
        repositories.register(ThemeConfigurationRepository(client: client, store: themeConfigurationStore))
        repositories.register(CustomerRepository(client: client, sessionStore: sessionStore))
        
        return Self(
            tasks: Tasks(repositories: repositories),
            state: AppState(sessionStore: sessionStore, themeConfigurationStore: themeConfigurationStore)
        )
    }()
    
}
