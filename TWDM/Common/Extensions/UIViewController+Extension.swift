//
//  UIViewController+Extension.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiateStoryBoard() -> UIViewController? {
        return UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController()
    }
    
}
