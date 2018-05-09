//
//  UIImageView+Extension.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/28.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(from url: URL) {
        if let cacheImage = ImageCache.sheard[url.absoluteString] {
            DispatchQueue.main.async {
                self.image = cacheImage
            }
            return
        } else {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let _ = response else {
                    return
                }
                let image = UIImage(data: data)
                ImageCache.sheard[url.absoluteString] = image
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            task.resume()
        }
    }
    
    func transformCircle() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = self.frame.size.width / 2
        layer.masksToBounds = true
    }
    
}
