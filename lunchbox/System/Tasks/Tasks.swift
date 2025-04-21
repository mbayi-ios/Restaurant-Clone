//
//  Tasks.swift
//  lunchbox
//
//  Created by Ambrose Mbayi on 21/04/2025.
//


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
