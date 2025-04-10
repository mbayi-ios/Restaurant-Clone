import Foundation

enum NovadineEndpoint: HTTPEndpoint {
    case theme_config
    case customers_signin
    case customers_me
    
    var base: String {
        return "/api/v2"
    }
    
    var location: String {
        switch self {
        case .theme_config:
            return "/theme-config/app"
            
        case .customers_signin:
            return "/customers/login"
        case .customers_me:
            return "/customers/me"
        }
    }
    
   
}
