//
//  RequestIdentifiable.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

public protocol RequestIdentifiable {
    var identifier: RequestIdentifier { get }
}
