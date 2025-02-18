import Foundation
import Combine
import UIKit

extension HTTPClient {
    enum HeaderKey: String {
        case tenant = "x-lbx-tenant"
        case contentType = "Content-Type"
        case authorization = "Authorization"
        case setCookie = "Set-Cookie"
        case cookie = "Cookie"
        case sessionId = "x-session-id"
        case platform = "x-lb-platform"
        case version = "x-lb-version"
        case osversion = "x-lb-osversion"
        case device = "x-lb-device"
        case deviceToken = "x-lb-devicetoken"
        case novadineApiKey = "ND-Api-Key"
        case acceptEncoding = "Accept-Encoding"
    }
}

class NovadineMessageContext: HTTPMessageContextual {
    
    static let sessionId = UUID().uuidString
    
    var scheme: URLScheme = .https
    var host = "\(Config.shared.tenant).\(Config.shared.hostUrl)"
    
    private var authToken: String?
    private var sessionToken: String?
    private var routeId: String?
    private var deviceToken: String?
    
    var headers: [String: String]
    {
        var contextHeaders = [
            HTTPClient.HeaderKey.contentType.rawValue: "application/json",
            HTTPClient.HeaderKey.novadineApiKey.rawValue: Config.shared.novadineApiKey,
            HTTPClient.HeaderKey.acceptEncoding.rawValue: "gzip"
        ]
        
        var cookie = ""
        if let authToken = authToken {
            cookie = authToken
        }
        
        if let sessionToken = sessionToken {
            cookie = cookie + "; " + sessionToken
        }
        
        if let routeId = routeId {
            cookie = cookie + "; " + routeId
        }
        
        // Fix ME:-
//        if !cookie.isBlank {
//            contextHeaders[HTTPClient.HeaderKey.cookie.rawValue] = cookie
//        }
        
        return contextHeaders
    }
    
    var noAuthHeaders : [String: String] {
        var contextHeaders = [
            HTTPClient.HeaderKey.contentType.rawValue: "application/json",
            HTTPClient.HeaderKey.novadineApiKey.rawValue: Config.shared.novadineApiKey,
            HTTPClient.HeaderKey.acceptEncoding.rawValue: "gzip"
        ]
        
        var cookie = ""
        if let sessionToken = sessionToken {
            cookie = sessionToken
        }
        if let routeId = routeId {
            cookie = cookie + "; " + routeId
        }
        
        // FixMe: -
//        if !cookie.isBlank {
//            contextHeaders[HTTPClient.HeaderKey.cookie.rawValue] = cookie
//        }
        
        return contextHeaders
    }
    

}


//https://pgtest.novadine.com/api/v2/stores/configuration
