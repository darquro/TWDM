//
//  FollowersViewController.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 86
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.register(FollowersTableViewCell.nib, forCellReuseIdentifier: FollowersTableViewCell.identifer)
            
            tableView.addSubview(refreshControll)
            refreshControll.addTarget(self, action: #selector(refreshRows), for: .valueChanged)
        }
    }
    
    private var refreshControll = UIRefreshControl()
    private var logOutBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(title: "LogOut", style: .done, target: self, action: #selector(self.logOutBarButtonItemAction(barButtonItem:)))
    }
    
    private let followerAPIClient = FollowerAPIClient()
    private var followerResponse: FollowerResponse?
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleView = NavigationItemTitleView()
        titleView.text = AppMenu.twitterDM.title
        titleView.onTapped = {
            self.tableView.scrollToTop()
        }
        self.navigationItem.titleView = titleView
        
        if let _ = Auth.currentSession {
            self.navigationItem.leftBarButtonItem = self.logOutBarButtonItem
            if !isLoading {
                isLoading = true
                self.loadData { self.isLoading = false }
            }
        } else {
            self.showLogInViewController()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadData(completion: (() -> Void)? = nil) {
        guard let _ = Auth.currentSession else {
            completion?()
            return
        }
        followerAPIClient.fetch { result in
            switch result {
            case .success(let response):
                self.followerResponse = response
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    completion?()
                }
            case .failure(let error):
                Log.d(error.localizedDescription)
                Alert.showDataResponseErrorAlert(self) {
                    completion?()
                }
            }
        }
    }
    
    private func loadNextData(completion: (() -> Void)? = nil) {
        guard let _ = Auth.currentSession,
            let nextCursor = self.followerResponse?.nextCursor
        else {
            completion?()
            return
        }
        followerAPIClient.fetch(nextCursor: nextCursor) { result in
            switch result {
            case .success(let response):
                self.followerResponse?.addNextResponse(response)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    completion?()
                }
            case .failure(let error):
                Log.d(error.localizedDescription)
                Alert.showDataResponseErrorAlert(self) {
                    completion?()
                }
            }
        }
    }
    
    @objc private func logOutBarButtonItemAction(barButtonItem: UIBarButtonItem) {
        Auth.logOut { result in
            switch result {
            case .success(_):
                Log.d("logout success")
                self.followerResponse = nil
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.showLogInViewController()
            case .failure(_):
                Log.d("logout failure")
            }
        }
    }
    
    private func showLogInViewController() {
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            window.rootViewController = LogInViewController.instantiateStoryBoard()!
        }
    }
    
    @objc private func refreshRows() {
        guard let _ = Auth.currentSession else {
            DispatchQueue.main.async {
                self.refreshControll.endRefreshing()
            }
            return
        }
        followerResponse = nil
        if !isLoading {
            isLoading = true
            self.loadData {
                DispatchQueue.main.async {
                    self.refreshControll.endRefreshing()
                }
                self.isLoading = false
            }
        }
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FollowersViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followerResponse?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: FollowersTableViewCell.identifer, for: indexPath) as? FollowersTableViewCell,
            let followers = self.followerResponse,
            indexPath.row < followers.users.count,
            let user = followers.users[indexPath.row]
        else {
            return UITableViewCell(frame: CGRect.zero)
        }
        
        cell.apply(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log.d("did select at \(indexPath.row)")
        guard let vc = DirectMessageViewController.instantiateStoryBoard() as? DirectMessageViewController,
            let follower = followerResponse?.users[indexPath.row]
        else {
            return
        }
        vc.follower = follower
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.didScrollEnd {
            if !isLoading {
                isLoading = true
                loadNextData { self.isLoading = false }
            }
        }
    }
}
