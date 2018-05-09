//
//  DirectMessageViewController.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

class DirectMessageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 70
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.register(DirectMessageRightTableViewCell.nib, forCellReuseIdentifier: DirectMessageRightTableViewCell.identifer)
            tableView.register(DirectMessageLeftTableViewCell.nib, forCellReuseIdentifier: DirectMessageLeftTableViewCell.identifer)
        }
    }
    @IBOutlet weak var messageInputBarContainer: UIView! {
        didSet {
            let messageInputBar = MessageInputBar.instantiateNib() as! MessageInputBar
            messageInputBarContainer.addSubview(messageInputBar)
            messageInputBarContainer.fitConstraint(subView: messageInputBar)
            messageInputBar.addObserverPostAction {
                self.postMessage(message: $0)
            }
        }
    }
    
    var follower: User? = nil
    private var userID: String? {
        return Auth.currentSession?.userID
    }
    private var directMessageAPIClient = DirectMessageAPIClient()
    private var directMessages: [DirectMessage] = []
    private var viewControllerKeyboardAjuster: UIViewControllerKeyboardAjuster?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let userID = userID, let follower = follower else {
            fatalError()
        }
        
        let titleView = NavigationItemTitleView()
        titleView.text = follower.screenNameWithAtmark
        titleView.onTapped = {
            self.tableView.scrollToTop()
        }
        self.navigationItem.titleView = titleView
        
        viewControllerKeyboardAjuster = UIViewControllerKeyboardAjuster(viewController: self)
        
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tableViewTapGuesture(gestureRecognizer:))))
        
        directMessageAPIClient.addObserverOnReceiveMessage { dm in
            self.directMessages.append(dm)
            self.tableView.reloadData()
        }
        directMessageAPIClient.fetch(userID: userID, followerID: String(follower.id)) { result in
            switch result {
            case .success(let value):
                if let messages = value {
                    self.directMessages += messages
                    self.tableView.scrollToBottom()
                }
            case .failure(let error):
                Log.d(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewControllerKeyboardAjuster?.addObserverViewAjustingKeyboardDisplay()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewControllerKeyboardAjuster?.removeObserverViewAjustingKeyboardDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func postMessage(message: String?) {
        guard let message = message, !message.isEmpty,
            let userID = userID,
            let follower = follower else {
            return
        }
        let dm = DirectMessage(userID: userID, followerID: String(follower.id), message: message, postBy: .user)
        directMessages.append(dm)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.tableView.scrollToBottom()
        directMessageAPIClient.post(dm: dm) { result in
            switch result {
            case .success(_):
                Log.d("post success")
            case .failure(_):
                Log.d("post failure")
            }
        }
    }
    
    @objc private func tableViewTapGuesture(gestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DirectMessageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < directMessages.count else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        let dm = directMessages[indexPath.row]
        guard let postBy = dm.postBy else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        switch postBy {
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: DirectMessageRightTableViewCell.identifer, for: indexPath) as! DirectMessageRightTableViewCell
            cell.message.text = dm.message
            return cell
        case .follower:
            let cell = tableView.dequeueReusableCell(withIdentifier: DirectMessageLeftTableViewCell.identifer, for: indexPath) as! DirectMessageLeftTableViewCell
            cell.message.text = dm.message
            return cell
        }
    }
    
}

