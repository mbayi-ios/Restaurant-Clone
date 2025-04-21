import Foundation
import Combine
import SwiftUI






protocol NetworkClient {
    func perform<Request: HTTPRequest>(_ request: Request, shouldSendAuthCookie: Bool) -> AnyPublisher<Request.Response, Error>
}

enum LBCookies: String, CaseIterable {
    case bffAuthToken = "__ac"
    case sessionToken = "Novadine.session"
    case routerId = "ROUTE_ID"
}






class HTTPClient: NetworkClient {
    private static let badRequestHttpStatusCode = 400
    
    private let context: HTTPMessageContextual
    private let session: URLSession
    private let encoder = HTTPClientEncoder()
    private let decoder = HTTPClientDecoder()
    
    init(context: HTTPMessageContextual, session: URLSession = URLSession(configuration: .default)) {
        self.context = context
        self.session = session
    }
    
    func perform<Request: HTTPRequest>(_ request: Request, shouldSendAuthCookie: Bool = true) -> AnyPublisher<Request.Response, Error> {
        guard let url = getValidRequestURL(for: request) else {
            return Fail(error: HTTPClientError.invalidBaseUrl).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = getRequestHeaders(for: request, shouldSendAuthCookie: shouldSendAuthCookie)
        
        if let httpBody = request.body {
            do {
                urlRequest.httpBody = try encoder.encode(httpBody)
            } catch {
                return Fail(error: HTTPClientError.invalidBody).eraseToAnyPublisher()
            }
        }
        
        cancelDuplicateRequest(for: urlRequest)
        
        urlRequest.cUrlLogDebug()
        print("network call is being made")
        
        return execute(urlRequest)
            .decode(type: Request.Response.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    private func execute(_ request: URLRequest) -> AnyPublisher<Data, Error> {
        session.dataTaskPublisher(for: request)
            .tryMap { [weak self] (data, response) in
                guard let self = self, let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPClientError.unknown(statusCode: HTTPClient.badRequestHttpStatusCode, data: data)
                }
                
                if let headers = httpResponse.allHeaderFields as? [String: String],
                   let url = response.url {
                    self.saveCookies(from: headers, url: url)
                }
                
                let statusCode = httpResponse.statusCode
                
                guard 200..<300 ~= statusCode else {
                    throw self.errorInfo(from: data, statusCode: statusCode)
                }
                
                return data
            }
            .eraseToAnyPublisher()
    }
    
    
}

extension HTTPClient {
    private func getValidRequestURL<Request: HTTPRequest>(for request: Request) -> URL? {
        var components  = URLComponents()
        components.path = request.path.endpoint
        
        if let queryItems = (request as? HTTPRequestQueryItems)?.queryItems,
           !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        let baseUrl = context.hostUrl
        return components.url(relativeTo: baseUrl)
    }
    
    func getRequestHeaders<Request: HTTPRequest>(for request: Request, shouldSendAuthCookie: Bool) -> [String: String] {
        var headers: [String: String] = shouldSendAuthCookie ? context.headers : ((context as? NovadineMessageContext)?.noAuthHeaders ?? context.headers)
        
        if let requestHeaders = (request as? HTTPRequestHeaders)?.headers {
            headers = headers.merging(requestHeaders, uniquingKeysWith: { (_, new) in  new })
        }
        return headers
    }
    
    private func errorInfo(from data: Data, statusCode: Int) -> Error {
        if let errorResponse = try? self.decoder.decode(HTTPErrorValidationResponse.self, from: data) {
            return HTTPClientError.validation(statusCode: statusCode, response: errorResponse)
        }
        
        if let errorResponse = try? self.decoder.decode(HTTPErrorMessageResponse.self, from: data) {
            return HTTPClientError.message(statusCode: statusCode, response: errorResponse)
        }
        
        if let message = String(data: data, encoding: .utf8) {
            if(self.isHtmlString(message)) {
                return HTTPClientError.unknown(statusCode: statusCode, data: data)
            } else {
                let errorResponse = HTTPErrorMessageResponse(message: message)
                return HTTPClientError.message(statusCode: statusCode, response: errorResponse)
            }
        }
        
        return HTTPClientError.unknown(statusCode: statusCode, data: data)
    }
    
    private func saveCookies(from headers: [String: String], url: URL) {
        _ = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
        
        // Fix ME:
        /*for lbcookie in LBCookies.allCases {
            if let responseCookie = cookies.first(where: { $0.name == lbcookie.rawValue }) {
                switch lbcookie {
                case .bffAuthToken:
                    let task = self.tasks.initialize(CustomerAuthTokenTask.self)
                    task.execute(with: "\(responseCookie.name)=\(responseCookie.value)")
                case .sessionToken:
                    let task = self.tasks.initialize(SessionTokenTask.self)
                    task.execute(with: "\(responseCookie.name)=\(responseCookie.value)")
                case .routeId:
                    let task = self.tasks.initialize(RouteCookieTask.self)
                    task.execute(with: "\(responseCookie.name)=\(responseCookie.value)")
                }
            }
        } */
    }
    
    private func cancelDuplicateRequest(for urlRequest: URLRequest) {
        session.getAllTasks { tasks in
            if let task = tasks.first(where: {
                $0.originalRequest?.url == urlRequest.url &&
                $0.originalRequest?.httpMethod == urlRequest.httpMethod
            }) {
                task.cancel()
            }
        }
    }
    
    func isHtmlString(_ value: String) -> Bool {
        if value.isEmpty {
            return false
        }
        return (value.range(of: "<(\"[^\"]*\"|'[^']*'|[^'\">])*>", options: .regularExpression) != nil)
    }
}
