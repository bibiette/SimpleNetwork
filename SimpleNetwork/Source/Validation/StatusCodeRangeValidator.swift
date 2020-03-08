//
//  StatusCodeRangeValidator.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation

struct StatusCodeRangeValidator {
    let range: Range<Int>
}

extension StatusCodeRangeValidator: ResponseValidating {
    func validate(sessionResponse: NetworkSession.Response) -> RequestResult<Data?> {
        switch (sessionResponse.response, sessionResponse.error) {
        case (.some(let urlResponse as HTTPURLResponse), _)
            where range ~= urlResponse.statusCode:
            return .success(sessionResponse.data)
        case (.some(let urlResponse as HTTPURLResponse), _):
            return .failure(NetworkError(statusCode: urlResponse.statusCode, payload: sessionResponse.data))
        case (_, .some(let error as URLError)):
            return .failure(NetworkError(statusCode: error.code.rawValue, payload: sessionResponse.data))
        default:
            return .failure(NetworkError(statusCode: -1, payload: sessionResponse.data))
        }
    }
}
