//
//  NavigationItemTitleView.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/05/01.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

class NavigationItemTitleView: UILabel {

    override var text: String? {
        set(value) {
            super.text = value
            textColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
            sizeToFit()
        }
        get {
            return super.text
        }
    }

    var onTapped: (() -> Void)? {
        willSet {
            isUserInteractionEnabled = true
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTappd(tapGestureRecognizer:))))
        }
    }
    
    @objc private func onTappd(tapGestureRecognizer: UITapGestureRecognizer) {
        onTapped?()
    }
}
