//
//  URLExtensions.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation

public extension URL {
    static func +(lhs: Self, rhs: String) -> Self {
        lhs.appendingPathComponent(rhs)
    }

    mutating func add(queryItems items: [String:String]) {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return }
        var queryItems = [URLQueryItem]()
        items.forEach { queryItems.append(.init(name: $0, value: $1)) }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return }
        self = url
    }
}
