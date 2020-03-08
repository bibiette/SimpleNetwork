//
//  NetworkService.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation

public protocol NetworkSession {
    typealias Response = (data: Data?, response: URLResponse?, error: Error?)

    func request(urlRequest: URLRequest) -> Validating & Resulting
    func upload(urlRequest: URLRequest) -> Validating & Progressing & Resulting
    func download(urlRequest: URLRequest) -> Validating & Progressing & Resulting
}
