import Foundation

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
    init(response: GetCustomerMeResponse) {
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
