import Foundation
import Combine

struct GetCustomerMeTask: TaskCombineNoninjectable {
    typealias RepositoryType = CustomerRepository
    typealias CombineResponse = Bool
    
    private let respository: RepositoryType
    
    init(repository: RepositoryType) {
        self.respository = repository
    }
    
    func execute() -> AnyPublisher<Bool, any Error> {
        return respository.getCustomerMe()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
