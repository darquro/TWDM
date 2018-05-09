//
//  Result.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

protocol ResultProtocol {
    associatedtype Value
    associatedtype Error: Swift.Error
    init(value: Value)
    init(error: Error)
}

enum Result<Value, Error: Swift.Error>: ResultProtocol {
    case success(Value)
    case failure(Error)
    
    init(value: Value) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
    
}
