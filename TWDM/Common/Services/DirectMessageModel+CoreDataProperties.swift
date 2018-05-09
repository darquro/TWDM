//
//  DirectMessageModel+CoreDataProperties.swift
//  
//
//  Created by yuki.kuroda on 2018/04/30.
//
//

import Foundation
import CoreData

extension DirectMessageModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DirectMessageModel> {
        return NSFetchRequest<DirectMessageModel>(entityName: "DirectMessageModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var userID: String?
    @NSManaged public var followerID: String?
    @NSManaged public var postAt: NSDate?
    @NSManaged public var message: String?
    @NSManaged public var postBy: Int16
    
    func apply(value: DirectMessage) throws {
        self.id = UUID()
        guard let userID = value.userID else {
            throw NSError(domain: "invalid value: userID", code: -1, userInfo: nil)
        }
        self.userID = userID
        guard let followerID = value.followerID else {
            throw NSError(domain: "invalid value: followerID", code: -1, userInfo: nil)
        }
        self.followerID = followerID
        guard let message = value.message else {
            throw NSError(domain: "invalid value: message", code: -1, userInfo: nil)
        }
        self.message = message
        guard let postBy = value.postBy else {
            throw NSError(domain: "invalid value: postBy", code: -1, userInfo: nil)
        }
        self.postBy = postBy.rawValue
        self.postAt = value.postAt as NSDate?
    }
}
