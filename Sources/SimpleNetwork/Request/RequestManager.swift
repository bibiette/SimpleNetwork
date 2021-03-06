//
//  RequestManager.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation

internal final class RequestManager: RequestManaging, RequestIdentifiable {
    private var progressHandler: Progressing.ProgressHandler?
    private var resultHandler: Resulting.ResultHandler?
    private var errorHandler: Resulting.ErrorHandler?
    private var successHandler: Resulting.SuccessHandler?
    
    private var validators = [ResponseValidating]()
    private var rangeValidator = StatusCodeRangeValidator(range: 200..<300)
    var observation: NSKeyValueObservation?
    
    var identifier: RequestIdentifier
    
    init() {
        self.identifier = 0
    }
    
    var progress: Float? {
        didSet {
            guard let progress = progress else { return }
            progressHandler?(progress)
            if progress == 1 {
                progressHandler = nil
            }
        }
    }

    var sessionResponse: NetworkSession.Response? {
        didSet {
            guard let sessionResponse = sessionResponse else { return }
            let result = validate(sessionResponse: sessionResponse)
            resultHandler?(result)
            switch result {
            case .failure(let error): errorHandler?(error)
            case .success(let data): successHandler?(data)
            }
            resultHandler = nil
            errorHandler = nil
            successHandler = nil
            progressHandler = nil
        }
    }

}

// MARK: - ResponseValidating
extension RequestManager: ResponseValidating {
    func validate(sessionResponse: NetworkSession.Response) -> RequestResult<Data?> {
        if validators.isEmpty { validators.append(rangeValidator) }
        for validator in validators {
            if case let .failure(error) = validator.validate(sessionResponse: sessionResponse) {
                return .failure(error)
            }
        }
        return .success(sessionResponse.data)
    }
}

// MARK: - Validating
extension RequestManager: Validating {
    func validate(statusCodeRange range:  Range<Int>) -> Self {
        let validator = StatusCodeRangeValidator(range: range)
        validators.append(validator)
        return self
    }
}

// MARK: - Resulting
extension RequestManager: Resulting {
    func done(then handler: @escaping Resulting.SuccessHandler) -> Self {
        successHandler = handler
        return self
    }
    
    func `catch`(then handler: @escaping Resulting.ErrorHandler) {
        errorHandler = handler
    }
    
    func result(then handler: @escaping Resulting.ResultHandler) {
        resultHandler = handler
    }
}

// MARK: - Progressing
extension RequestManager: Progressing {
    func progress(then handler: @escaping ProgressHandler) -> Self {
        progressHandler = handler
        return self
    }
}
