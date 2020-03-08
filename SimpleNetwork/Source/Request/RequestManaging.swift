//
//  RequestManaging.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation

public protocol RequestManaging {
    var sessionResponse: NetworkSession.Response? { get set }
    var progress: Float? { get set }
}

typealias ResultHandler = (RequestResult<Data?>) -> Void
