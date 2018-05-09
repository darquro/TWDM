//
//  DirectMessageLeftTableViewCell.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/28.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

class DirectMessageLeftTableViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        message.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
