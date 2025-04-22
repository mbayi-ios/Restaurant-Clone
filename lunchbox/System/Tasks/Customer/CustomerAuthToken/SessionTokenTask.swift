struct SessionTokenTask: TaskInjectable {
    typealias RepositoryType = CustomerRepository
    typealias Model = String
    
    private let repository: RepositoryType
    
    init(repository: RepositoryType) {
        self.repository = repository
    }
    
    func execute(with object: Model) {
        repository.setSessionToken(token: object)
    }
}

struct RouteCookieTask: TaskInjectable {
    typealias RepositoryType = CustomerRepository
    typealias Model = String
    
    private let repository: RepositoryType
    
    init(repository: RepositoryType) {
        self.repository = repository
    }
    
    func execute(with object: Model) {
        repository.setRouteId(routeId: object)
    }
}


