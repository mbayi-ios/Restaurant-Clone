//
//  Repositories.swift
//  lunchbox
//
//  Created by Ambrose Mbayi on 21/04/2025.
//


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