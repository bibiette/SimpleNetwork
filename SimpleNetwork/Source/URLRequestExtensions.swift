//
//  URLRequestExtensions.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation

public extension URLRequest {
    static func make(endpoint: URL, headers: [Header] = [], method: Method = .get) -> Self {
        let urlRequest = NSMutableURLRequest(url: endpoint)
        headers.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        urlRequest.httpMethod = method.rawValue
        return urlRequest as URLRequest
    }
}
