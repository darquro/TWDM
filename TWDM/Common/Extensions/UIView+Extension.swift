//
//  UIView+Extension.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

extension UIView {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func instantiateNib() -> UIView {
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func fitConstraint(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: subView.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: subView.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: subView.rightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: subView.bottomAnchor).isActive = true
    }
}
