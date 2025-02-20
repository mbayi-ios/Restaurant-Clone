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
    let themeConfigurationState: ThemeConfigurationState
    let themeConfigurationStore: ThemeConfigurationStore
    
    init(themeConfigurationStore: ThemeConfigurationStore) {
        self.themeConfigurationState = ThemeConfigurationState(themeConfigurationStore: themeConfigurationStore)
        self.themeConfigurationStore = themeConfigurationStore
    }
}

struct DependencyContainer: EnvironmentKey {
    let tasks: Tasks
    let state: AppState
    
    static var defaultValue: Self { Self.default}
    
    private static var `default` : Self = {
        let context = NovadineMessageContext()
        let client = HTTPClient(context: context)
        let themeConfigurationStore = ThemeConfigurationStore()
        
        let repositories = Repositories()
        
        repositories.register(ThemeConfigurationRepository(client: client, store: themeConfigurationStore))
        
        return Self(
            tasks: Tasks(repositories: repositories),
            state: AppState(themeConfigurationStore: themeConfigurationStore)
        )
    }()
    
}

extension EnvironmentValues {
    var dependencies: DependencyContainer {
        get { self[DependencyContainer.self] }
        set { self[DependencyContainer.self] = newValue }
    }
}
