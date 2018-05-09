//
//  UIViewControllerKeyboardAjuster.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/28.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

class UIViewControllerKeyboardAjuster {
    
    private var viewController: UIViewController?
    private var beforeKeyboardShownFrame: CGRect?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func addObserverViewAjustingKeyboardDisplay() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(viewShrinkWhenKeyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(viewExpandWhenKeyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func removeObserverViewAjustingKeyboardDisplay() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func viewShrinkWhenKeyboardWillShow(notification: Notification?) {
        guard let viewController = viewController,
            let rect = (notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
            else {
                return
        }

        // 2回呼ばれることがあるので、初回のサイズのみ保持する
        if beforeKeyboardShownFrame == nil {
            beforeKeyboardShownFrame = viewController.view.bounds
        }
        guard let bounds = beforeKeyboardShownFrame else { return }
        UIView.animate(withDuration: duration) {
            viewController.view.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height - rect.size.height)
        }
    }
    
    @objc func viewExpandWhenKeyboardWillHide(notification: Notification?) {
        guard let duration = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let rect = beforeKeyboardShownFrame,
            let viewController = viewController
            else {
                return
        }

        UIView.animate(withDuration: duration) {
            viewController.view.frame = rect
            self.beforeKeyboardShownFrame = nil
        }
    }
}
