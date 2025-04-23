import Foundation
import Combine
import SwiftUI

protocol NetworkClient {

    func perform<Request: HTTPRequest>(_ request: Request, shouldSendAuthCookie: Bool) -> AnyPublisher<Request.Response, Error>
}

enum LBCookies: String, CaseIterable {
    case bffAuthToken = "__ac"
    case sessionToken = "NovaDine.session"
    case routeId = "ROUTE_ID"
}

class HTTPClient: NetworkClient
{
    // FIXME: Don't think we want SwiftUI in here
    @Environment(\.dependencies.tasks) var tasks
    
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

        print("encoded", urlRequest)
        if let httpBody = request.body {
            do {
                urlRequest.httpBody = try encoder.encode(httpBody)
            } catch {
                return Fail(error: HTTPClientError.invalidBody).eraseToAnyPublisher()
            }
            
        }
        
        cancelDuplicateRequest(for: urlRequest)

        urlRequest.cUrlLogDebug()

        print("network is being called")
        return execute(urlRequest)
            .decode(type: Request.Response.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    private func execute(_ request: URLRequest) -> AnyPublisher<Data, Error> {
        session.dataTaskPublisher(for: request)
            .tryMap { [weak self] (data, response) -> Data in
                print("hello")
                // Validate response
                guard let self = self, let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPClientError.unknown(statusCode: HTTPClient.badRequestHttpStatusCode, data: data)
                }

                // Fetch and save required cookies from response headers
                if let headers = httpResponse.allHeaderFields as? [String: String],
                    let url = response.url {
                    self.saveCookies(from: headers, url: url)
                }

                // Check if request was successful (2xx response code)
                let statusCode = httpResponse.statusCode

                guard 200..<300 ~= statusCode else {
                    throw self.errorInfo(from: data, statusCode: statusCode)
                }
                print("data is data and ", data)
                return data
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Request helper methods
extension HTTPClient {
    
    // Returns complete API url with params
    private func getValidRequestURL<Request: HTTPRequest>(for request: Request) -> URL? {
        var components = URLComponents()
        components.path = request.path.endpoint
        
        if let queryItems = (request as? HTTPRequestQueryItems)?.queryItems,
           !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        let baseUrl = context.hostUrl
        return components.url(relativeTo: baseUrl)
    }
    
    
    private func getRequestHeaders<Request: HTTPRequest>(for request: Request, shouldSendAuthCookie: Bool) -> [String: String] {
        var headers: [String: String] = shouldSendAuthCookie ? context.headers : ((context as? NovadineMessageContext)?.noAuthHeaders ?? context.headers)
        
        if let requestHeaders = (request as? HTTPRequestHeaders)?.headers {
            headers = headers.merging(requestHeaders, uniquingKeysWith: { (_, new) in new })
        }
        
        return headers
    }
    
    private func cancelDuplicateRequest(for urlRequest: URLRequest) {
        session.getAllTasks { tasks in
            if let task = tasks.first(where: {
                $0.originalRequest?.url == urlRequest.url &&
                $0.originalRequest?.httpMethod == urlRequest.httpMethod
            })
            {
                task.cancel()
            }
        }
    }
}

// MARK: - Response helper methods
extension HTTPClient {
    
    private func errorInfo(from data: Data, statusCode: Int) -> Error
    {
        if let errorResponse = try? self.decoder.decode(HTTPErrorValidationResponse.self, from: data) {
            return HTTPClientError.validation(statusCode: statusCode, response: errorResponse)
        }

        if let errorResponse = try? self.decoder.decode(HTTPErrorMessageResponse.self, from: data) {
            return HTTPClientError.message(statusCode: statusCode, response: errorResponse)
        }

        if let message = String(data: data, encoding: .utf8)
        {
            if(self.isHtmlString(message))
            {
                return HTTPClientError.unknown(statusCode: statusCode, data: data)
                
            }
            else
            {
                let errorResponse = HTTPErrorMessageResponse(message: message)
                return HTTPClientError.message(statusCode: statusCode, response: errorResponse)
            }
            
        }

        return HTTPClientError.unknown(statusCode: statusCode, data: data)
    }
    
    private func saveCookies(from headers: [String: String], url: URL) {
        // Get the cookies from the headers
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
        
        for lbcookie in LBCookies.allCases {
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
        }
    }
    
    func isHtmlString(_ value: String) -> Bool {
        if value.isEmpty {
            return false
        }
        return (value.range(of: "<(\"[^\"]*\"|'[^']*'|[^'\">])*>", options: .regularExpression) != nil)
    }
}
