import Foundation

struct HTTPErrorValidationResponse: Decodable {
    struct ValidationError: Decodable {
        let param: String
        let location: String
        let message: String
    }
    
    let errors: [ValidationError]
}

struct HTTPErrorMessageResponse: Decodable {
    let message: String
}

extension HTTPClient {
    enum HTTPClientError: LocalizedError {
        case unknown(statusCode: Int, data: Data)
        case invalidBaseUrl
        case invalidBody
        case validation(statusCode: Int, response: HTTPErrorValidationResponse)
        case message(statusCode: Int, response: HTTPErrorMessageResponse)
    }
}
