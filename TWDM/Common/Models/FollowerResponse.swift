//
//  FollowerResponse.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

struct FollowerResponse: Codable {
    var nextCursor: String
    var users: [User?]
    
    private enum CodingKeys: String, CodingKey {
        case nextCursor = "next_cursor_str"
        case users
    }
    
    mutating func addNextResponse(_ nextResponse: FollowerResponse) {
        self.nextCursor = nextResponse.nextCursor
        self.users += nextResponse.users
    }
    
    static func decode(from data: Data) throws -> FollowerResponse {
        do {
            let response = try JSONDecoder().decode(FollowerResponse.self, from: data)
            return response
        } catch let error {
            throw error
        }
    }
}
