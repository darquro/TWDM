//
//  Auth.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation
import TwitterKit

struct Auth {
    
    static func logIn(completion: @escaping (Result<TWTRAuthSession, RequestErrors>) -> Void) {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if let s = session {
                Log.d("logged in user with id \(s.userID)")
                completion(.success(s))
            } else {
                Log.d("login error")
                completion(.failure(.authorizationError))
            }
        }
    }
    
    static func logOut(completion: @escaping (Result<TWTRAuthSession, RequestErrors>) -> Void) {
        let sessionStore = TWTRTwitter.sharedInstance().sessionStore
        guard let session = sessionStore.session() else {
            completion(.failure(.authorizationError))
            return
        }
        sessionStore.logOutUserID(session.userID)
        completion(.success(session))
    }
    
    static var currentSession: TWTRAuthSession? {
        return TWTRTwitter.sharedInstance().sessionStore.session()
    }
}
