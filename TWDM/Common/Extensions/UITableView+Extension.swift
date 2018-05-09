//
//  UITableView+Extension.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/29.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

extension UITableView {
    
    var didScrollEnd: Bool {
        let currentOffset = self.contentOffset.y
        let contentsHeight = self.contentSize.height
        let frameHeight = self.frame.size.height
        let maximumOffset = contentsHeight - frameHeight
        
        if (maximumOffset - currentOffset) <= 40 {
            return true
        }
        return false
    }
    
    func scrollToTop(section: Int = 0) {
        let indexPath = IndexPath(row: 0, section: section)
        DispatchQueue.main.async {
            self.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func scrollToBottom(section: Int = 0) {
        guard let count = self.dataSource?.tableView(self, numberOfRowsInSection: section),
            count > 0
        else {
            return
        }
        let indexPath = IndexPath(row: count - 1, section: section)
        DispatchQueue.main.async {
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}
