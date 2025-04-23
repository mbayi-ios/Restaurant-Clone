import Foundation
import Combine
import UIKit

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
        let contextHeaders = [
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
        let contextHeaders = [
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
    
    private let sessionStore: SessionStore
    private var cancellables: Set<AnyCancellable> = []
    
    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
        
        sessionStore.currentAuthToken
            .sink { token in
                self.authToken = token
            }.store(in: &cancellables)
        
        sessionStore.currentSessionToken
            .sink { token in
                self.sessionToken = token
            }.store(in: &cancellables)
        
        sessionStore.currentRouteId
            .sink { token in
                self.routeId = token
            }.store(in: &cancellables)
    }
}


//https://pgtest.novadine.com/api/v2/stores/configuration
