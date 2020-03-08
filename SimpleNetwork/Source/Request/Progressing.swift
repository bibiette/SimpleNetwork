//
//  Progressing.swift
//  SimpleNetwork
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

public protocol Progressing {
    typealias ProgressHandler = (Float) -> Void

    func progress(then handler: @escaping ProgressHandler) -> Self
}
