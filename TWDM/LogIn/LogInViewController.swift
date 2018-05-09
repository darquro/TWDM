//
//  LogInViewController.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/05/02.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit
import TwitterKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if let error = error {
                Log.d("error: \(error.localizedDescription)");
                return
            }
            if let session = session {
                Log.d("signed in as \(session.userName)");
                if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                    window.rootViewController = FollowersViewController.instantiateStoryBoard()
                }
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
