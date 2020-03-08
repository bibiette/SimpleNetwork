//
//  NetworkError.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation

public struct NetworkError: Error {
    let statusCode: Int
    var payload: Data? = nil
}
