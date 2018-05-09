//
//  FollowersTableViewCell.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

class FollowersTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.transformCircle()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userName.text = ""
        self.screenName.text = ""
        self.profileImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func apply(user: User) {
        userName.text = user.name
        screenName.text = user.screenNameWithAtmark
        profileImageView.image = nil
        if let profileImageURL = URL(string: user.profileImageURLString) {
            profileImageView.setImage(from: profileImageURL)
        }
    }
    
}
