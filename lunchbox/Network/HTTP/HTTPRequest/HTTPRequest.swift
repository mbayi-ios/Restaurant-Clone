import Foundation

protocol HTTPRequest {

    associatedtype Payload: Encodable
    associatedtype Response: Decodable

    var method: HTTPMethod { get }
    var path: HTTPEndpoint { get }
    var body: Payload? { get }
}
