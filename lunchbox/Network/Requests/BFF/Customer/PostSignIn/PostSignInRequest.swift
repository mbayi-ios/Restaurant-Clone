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
