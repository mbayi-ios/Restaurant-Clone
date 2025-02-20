import Foundation

enum NovadineEndpoint: HTTPEndpoint {
    case theme_config
    
    var base: String {
        return "/api/v2"
    }
    
    var location: String {
        switch self {
        case .theme_config:
            return "/theme-config/app"
        }
    }
    
   
}
