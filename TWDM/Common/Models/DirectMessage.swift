//
//  DirectMessage.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/28.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

struct DirectMessage {
    var id: UUID?
    var userID: String?
    var followerID: String?
    var message: String?
    var postBy: DirectMessageAccount?
    var postAt: Date?
    
    init() {}
    
    init(userID: String, followerID: String, message: String, postBy: DirectMessageAccount) {
        self.id = UUID()
        self.userID = userID
        self.followerID = followerID
        self.message = message
        self.postBy = postBy
        self.postAt = Date()
    }
    
    static func convert(from model: DirectMessageModel) -> DirectMessage? {
        var dm = DirectMessage()
        guard let _id = model.id,
            let _userID = model.userID,
            let _followerID = model.followerID,
            let _message = model.message,
            let _postAt = model.postAt
        else {
            return nil
        }
        dm.id = _id
        dm.userID = _userID
        dm.followerID = _followerID
        dm.message = _message
        dm.postBy = DirectMessageAccount(rawValue: model.postBy)
        dm.postAt = _postAt as Date
        return dm
    }
}

enum DirectMessageAccount: Int16 {
    case user = 0
    case follower = 1
}
