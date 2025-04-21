//
//  HTTPEndpoint.swift
//  lunchbox
//
//  Created by Ambrose Mbayi on 21/04/2025.
//


protocol HTTPEndpoint {
    var base: String { get }
    var location: String { get }
}

extension HTTPEndpoint {
    var endpoint: String {
        return "\(base)\(location)"
    }
}
