//
//  Alert.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/05/03.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

class Alert {
    static func showDataResponseErrorAlert(_ viewController: UIViewController, complition: (() -> Void)? = nil) {
        let title = "エラー"
        let message = "データの取得に失敗しました。通信状況を確認してください。"
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancel)
        viewController.present(alert, animated: true, completion: {
            complition?()
        })
    }
}
