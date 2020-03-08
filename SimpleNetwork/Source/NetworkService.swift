//
//  NetworkService.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation

public protocol NetworkService: class {
    var session: NetworkSession { get set }

    func request(urlRequest: URLRequest) -> Validating & Resulting
    func upload(urlRequest: URLRequest) -> Validating & Progressing & Resulting
    func download(urlRequest: URLRequest) -> Validating & Progressing & Resulting
}

public extension NetworkService {    
    func request(urlRequest: URLRequest) -> Validating & Resulting {
        session.request(urlRequest: urlRequest)
    }
    
    func upload(urlRequest: URLRequest) -> Validating & Progressing & Resulting {
        session.upload(urlRequest: urlRequest)
    }
    
    func download(urlRequest: URLRequest) -> Validating & Progressing & Resulting {
        session.download(urlRequest: urlRequest)
    }
}
