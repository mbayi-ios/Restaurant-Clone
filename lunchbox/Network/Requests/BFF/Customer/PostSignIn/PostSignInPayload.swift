
struct PostSignInPayload: Encodable {
    let username: String
    let password: String
    
    init(email: String, password: String) {
        self.username = email
        self.password = password
    }
}
