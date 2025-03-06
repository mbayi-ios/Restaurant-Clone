import Combine
import SwiftUI

struct PostSignInPayload: Encodable {
    let username: String
    let password: String
    
    init(email: String, password: String) {
        self.username = email
        self.password = password
    }
}

struct PostSignInResponse: Decodable {
    let customer_id: Int
    let auth_cookie: String
}

struct PostSignInRequest: HTTPRequest {
    typealias Payload = PostSignInPayload
    typealias Response = PostSignInResponse
    
    init(payload: Payload) {
        body = payload
    }
    
    let path: HTTPEndpoint = NovadineEndpoint.customers_signin
    let method = HTTPMethod.POST
    var body: Payload?
}

extension PostSignInRequest.Payload {
    init(taskModel: SignInTaskModel) {
        self.init(email: taskModel.email, password: taskModel.password)
    }
}

struct CustomerRepository: Repository {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
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
}
