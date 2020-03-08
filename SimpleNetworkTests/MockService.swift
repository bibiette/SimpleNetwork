//
//  MockService.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation
@testable import SimpleNetwork

final class MockService: NetworkService {
    var session: NetworkSession
    
    init() {
        session = URLSession(configuration: .default)
    }
}
