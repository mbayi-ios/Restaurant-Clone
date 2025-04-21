//
//  HTTPRequest.swift
//  lunchbox
//
//  Created by Ambrose Mbayi on 21/04/2025.
//


protocol HTTPRequest {
    associatedtype Payload: Encodable
    associatedtype Response: Decodable
    
    var method: HTTPMethod { get }
    var path: HTTPEndpoint { get }
    var body: Payload? { get }
}