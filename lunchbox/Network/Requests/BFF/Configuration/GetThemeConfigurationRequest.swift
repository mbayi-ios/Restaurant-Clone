import Foundation
struct GetThemeConfigurationRequest: HTTPRequest {
    typealias Payload = GetThemeConfigurationPayload
    typealias Response = GetThemeConfigurationResponse
    
    let path: HTTPEndpoint = NovadineEndpoint.theme_config
    
    let method = HTTPMethod.GET
    var body: Payload?
}
