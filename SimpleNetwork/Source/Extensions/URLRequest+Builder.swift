//
//  URLRequestExtensions.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation

public extension URLRequest {
    class Builder {
        var url: URL!
        var queryItems: [String:String] = .init()
        var headers: [Header] = .init()
        var method: Method = .get
        var cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy
        var timeoutInterval: TimeInterval = 60
        
        convenience init(closure: (Builder) -> Void) {
            self.init()
            closure(self)
        }
        
        func build() -> URLRequest {
            url.add(queryItems: queryItems)
            let urlRequest = NSMutableURLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
            headers.forEach {
                urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
            }
            urlRequest.httpMethod = method.rawValue
            return urlRequest as URLRequest
        }
    }
    
    static func make(endpoint: URL,
                     queryItems: [String: String] = [:],
                     headers: [Header] = [],
                     method: Method = .get,
                     cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy,
                     timeoutInterval: TimeInterval = 60) -> Self {
        Builder {
            $0.url = endpoint
            $0.queryItems = queryItems
            $0.headers = headers
            $0.method = method
            $0.cachePolicy = cachePolicy
            $0.timeoutInterval = timeoutInterval
        }.build()
    }
}
