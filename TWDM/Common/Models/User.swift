//
//  User.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Double
    let name: String
    let screenName: String
    var screenNameWithAtmark: String {
        return "@\(screenName)"
    }
    let profileImageURLString: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case profileImageURLString = "profile_image_url_https"
    }
}
