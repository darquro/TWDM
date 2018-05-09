//
//  RequestErrors.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

enum RequestErrors: Error {
    case requestError
    case responseError
    case authorizationError
    case saveDataError
}
