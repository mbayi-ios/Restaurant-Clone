//
//  CustomAuthTokenTask.swift
//  lunchbox
//
//  Created by Ambrose Mbayi on 22/04/2025.
//


struct CustomerAuthTokenTask: TaskInjectable {
    typealias RepositoryType = CustomerRepository
    typealias Model = String
    
    private let repository: RepositoryType
    
    init(repository: RepositoryType) {
        self.repository = repository
    }
    
    func execute(with object: String) {
        repository.setCustomerAuthorization(token: object)
    }
}
