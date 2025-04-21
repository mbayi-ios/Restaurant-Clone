import Combine
import SwiftUI

struct CustomerRepository: Repository {
    private let client: HTTPClient
    private let sessionStore: SessionStore
    
    init(client: HTTPClient, sessionStore: SessionStore) {
        self.client = client
        self.sessionStore = sessionStore
    }
    
    func authenticate(with taskModel: SignInTask.Model) -> AnyPublisher<PostSignInResponse, Error> {
        let payload = PostSignInRequest.Payload(taskModel: taskModel)
        let request = PostSignInRequest(payload: payload)
        
        return client.perform(request)
            .receive(on: DispatchQueue.main)
            .tryMap { response in
                return response
            }.eraseToAnyPublisher()
    }
    
    func getCustomerMe() -> AnyPublisher<Bool, Error> {
        let request = GetCustomerMeRequest()
        
        return client.perform(request).tryMap { response in
            _ = Customer(response: response)
            return true
        }.eraseToAnyPublisher()
    }
    
    func signOut() {
        sessionStore.clear()
    }
}
