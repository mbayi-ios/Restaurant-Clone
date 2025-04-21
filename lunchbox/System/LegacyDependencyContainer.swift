import SwiftUI

class Repositories {
    private var repositories = [String: Repository]()
    
    func register<R: Repository> (_ reporsitory: R) {
        repositories["\(R.self)"] = reporsitory
    }
    
    func resolve<R: Repository>(_ repositoryType: R.Type) -> R {
        guard let repository = repositories["\(R.self)"] as? R else {
            fatalError("Attempting to access a repository that hasnt been registered inside DependencyContainer")
        }
        
        return repository
    }
}
struct Tasks {
    private let repositories: Repositories
    
    init(repositories: Repositories) {
        self.repositories = repositories
    }
    
    func initialize<T: Task> (_ type: T.Type) -> T {
        let repository = repositories.resolve(T.RepositoryType.self)
        return T(repository: repository)
    }
}

struct AppState {
    let sessionStore: SessionStore
    let themeConfigurationState: ThemeConfigurationState
    let themeConfigurationStore: ThemeConfigurationStore
    
    let authStatus: AuthStatus
    
    init(sessionStore: SessionStore, themeConfigurationStore: ThemeConfigurationStore) {
        self.sessionStore = sessionStore
        self.themeConfigurationState = ThemeConfigurationState(themeConfigurationStore: themeConfigurationStore)
        self.themeConfigurationStore = themeConfigurationStore
        
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
        repositories.register(CustomerRepository(client: client))
        
        return Self(
            tasks: Tasks(repositories: repositories),
            state: AppState(sessionStore: sessionStore, themeConfigurationStore: themeConfigurationStore)
        )
    }()
    
}

extension EnvironmentValues {
    var dependencies: DependencyContainer {
        get { self[DependencyContainer.self] }
        set { self[DependencyContainer.self] = newValue }
    }
}
