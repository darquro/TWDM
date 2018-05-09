//
//  ImageCache.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/29.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

final class ImageCache: NSCache<AnyObject, UIImage> {
    
    static let sheard = ImageCache()
    private var memoryWarningObserver: NSObjectProtocol!
    
    override init() {
        super.init()
        memoryWarningObserver = NotificationCenter.default.addObserver(forName: .UIApplicationDidReceiveMemoryWarning, object: nil, queue: nil) { _ in
            self.removeAllObjects()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(memoryWarningObserver)
    }
    
    subscript(key: String) -> UIImage? {
        get {
            return object(forKey: key as AnyObject)
        }
        set (newValue) {
            if let object = newValue {
                setObject(object, forKey: key as AnyObject)
            } else {
                removeObject(forKey: key as AnyObject)
            }
        }
    }
}
