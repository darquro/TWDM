//
//  String+Extension.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/05/02.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

extension String {
    
    static func random(_ length: Int) -> String {
        let chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        var str = ""
        for _ in 0 ..< length {
            let random = Int(arc4random_uniform(UInt32(chars.count)))
            str += String(chars[chars.index(chars.startIndex, offsetBy: random)])
        }
        return str
    }
    
}
