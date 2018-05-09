//
//  Date+Extension.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/05/03.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

extension Date {
    
    func toString() -> String {
        return Date.dateFormatter.string(from: self)
    }
    
    fileprivate static let dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    fileprivate static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
}
