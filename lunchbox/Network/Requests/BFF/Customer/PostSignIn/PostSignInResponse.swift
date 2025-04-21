struct PostSignInResponse: Decodable {
    let customer_id: Int
    let auth_cookie: String
}
