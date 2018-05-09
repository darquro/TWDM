//
//  AppMenu.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/29.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

enum AppMenu {
    case twitterDM
    
    var title: String {
        switch self {
        case .twitterDM: return "Twitter DM"
        }
    }
}
