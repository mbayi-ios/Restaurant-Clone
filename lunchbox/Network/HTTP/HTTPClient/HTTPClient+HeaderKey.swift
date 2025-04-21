import Foundation

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
