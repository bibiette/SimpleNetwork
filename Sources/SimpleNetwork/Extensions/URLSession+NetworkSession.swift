//
//  URLSessionExtensions.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import Foundation

extension URLSession: NetworkSession {
    public func request(urlRequest: URLRequest) -> Validating & Resulting {
        request(with: urlRequest)
    }
    
    public func upload(urlRequest: URLRequest) -> Validating & Progressing & Resulting {
        request(with: urlRequest)
    }
    
    public func download(urlRequest: URLRequest) -> Validating & Progressing & Resulting {
        request(with: urlRequest)
    }
}

// MARK: - URLSession+NetworkSession Helpers
private extension URLSession {
    func request(with request: URLRequest) -> RequestManager {
        var requestManager: RequestManager? = .init()
        let task = dataTask(with: request) { data, response, error in
            requestManager?.sessionResponse = ((data, response, error))
            requestManager = nil
        }
        task.resume()
        requestManager!.identifier = task.taskIdentifier
        return requestManager!
    }
    
    func upload(with request: URLRequest) -> RequestManager {
        var requestManager: RequestManager? = .init()
        let task = uploadTask(with: request, from: request.httpBody) { data, response, error in
            requestManager?.sessionResponse = ((data, response, error))
            requestManager = nil
        }
        if #available(iOS 11, *) {
            requestManager!.observation = task.observe(\.progress, options: [.new]) { [weak requestManager] (task, value) in
                guard let progress = value.newValue else { return }
                requestManager?.progress = Float(progress.fractionCompleted)
            }
        }
        task.resume()
        requestManager!.identifier = task.taskIdentifier
        return requestManager!
    }
    
    func download(with request: URLRequest) -> RequestManager {
        var requestManager: RequestManager? = .init()
        let task = downloadTask(with: request) { url, response, error in
            defer {
                requestManager = nil
            }
            guard let url = url, let data = try? Data(contentsOf: url) else {
                requestManager?.sessionResponse = ((nil, response, error))
                return
            }
            requestManager?.sessionResponse = ((data, response, error))
        }
        if #available(iOS 11, *) {
            requestManager!.observation = task.observe(\.progress, options: [.new]) { [weak requestManager] (task, value) in
                guard let progress = value.newValue else { return }
                requestManager?.progress = Float(progress.fractionCompleted)
            }
        }
        task.resume()
        requestManager!.identifier = task.taskIdentifier
        return requestManager!
    }
}
