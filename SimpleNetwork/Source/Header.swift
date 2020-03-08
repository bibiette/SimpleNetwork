//
//  Header.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

public struct Header {
    let key: String
    var value: String
    
    public init(key: String, value: String = "") {
        self.key = key
        self.value = value
    }
    
    public func value(_ value: String) -> Header {
        return Header(key: key, value: value)
    }
}
