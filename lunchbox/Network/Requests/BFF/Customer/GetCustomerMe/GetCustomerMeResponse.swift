struct GetCustomerMeResponse: Decodable {
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
    let errors: ErrorsType?
    let ok: Bool?
}

enum ErrorsType: Codable {
    case errorMap([String: [String]]?)
}
