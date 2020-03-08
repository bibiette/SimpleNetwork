//
//  Resulting.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation

public typealias RequestResult<T> = Result<T, NetworkError>

public protocol Resulting: class {
    typealias ResultHandler = (RequestResult<Data?>) -> Void

    func result(then handler: @escaping ResultHandler)
}
