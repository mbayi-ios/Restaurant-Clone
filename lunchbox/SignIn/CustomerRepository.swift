import Combine
import SwiftUI

struct Customer: Codable {
    let customerId: Int
    var firstName: String
    var lastName: String
    var phone: String
    let isGuest: Bool?
    let isVerified: Bool
    let isPhoneVerified: Bool
    var email: String
    var birthdate: String?
    let emailOptin: Bool?
    let phoneOptin: Bool?
    var error: String? = nil
   // var errors: ErrorTypes? = nil
    var ok: Bool? = nil
    
    func fullName() -> String {
        return firstName + " " + lastName
    }
}
extension Customer {
    init(response: GetCustomerResponse) {
        self.customerId = response.customer_id ?? -1
        self.firstName = response.first_name ?? ""
        self.lastName = response.last_name ?? ""
        self.phone = response.phone ?? ""
        self.isGuest = response.is_guest
        self.isVerified = response.is_verified ?? false
        self.isPhoneVerified = response.is_phone_verified ?? false
        self.email = response.email ?? ""
        self.birthdate = response.birthdate
        self.emailOptin = response.optin
        self.phoneOptin = response.sms_optin
        self.error = response.error
        //self.errors = response.errors
        self.ok = response.ok
    }
}
struct GetCustomerMePayload: Encodable {
    
}

struct GetCustomerResponse: Decodable {
    let customer_id: Int?
    let first_name: String?
    let last_name: String?
    let phone: String?
    let is_guest: Bool?
    let is_verified: Bool?
    let is_phone_verified: Bool?
    let email: String?
    let birthdate: String?
    let optin: Bool?
    let sms_optin: Bool?
    
    let address1: String?
    let address2: String?
    let city: String?
    let state: String?
    let postal_code: String?
    let latitude: Float?
    let longitude: Float?
    let error: String?
   // let errors: ErrorsTypes?
    let ok: Bool?
}

struct GetCustomerMeRequest: HTTPRequest {
    typealias Payload = GetCustomerMePayload
    typealias Response = GetCustomerResponse
    
    let path: HTTPEndpoint = NovadineEndpoint.customers_me
    let method = HTTPMethod.GET
    var body: Payload?
}

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
    
    func getCustomerMe() -> AnyPublisher<Bool, Error> {
        let request = GetCustomerMeRequest()
        
        return client.perform(request).tryMap { response in
            _ = Customer(response: response)
            return true
        }.eraseToAnyPublisher()
    }
}
