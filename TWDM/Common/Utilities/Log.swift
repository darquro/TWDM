//
//  Log.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/05/03.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation

enum LogLevel: UInt {
    case v = 0 // verbose
    case d = 1 // debug
    case e = 2 // error
    case w = 3 // warning
    case i = 4 // info
    
    var string: String {
        switch self {
        case .v: return "🔬"
        case .d: return "💬"
        case .e: return "‼️"
        case .w: return "⚠️"
        case .i: return "ℹ️"
        }
    }
}

struct Log {
    
    static var logLevel: LogLevel = .e
    
    static func v(_ message: String, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        out(message: message, logLevel: .v, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    static func d(_ message: String, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        out(message: message, logLevel: .d, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    static func e(_ message: String, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        out(message: message, logLevel: .e, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    static func w(_ message: String, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        out(message: message, logLevel: .w, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    static func i(_ message: String, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        out(message: message, logLevel: .i, fileName: fileName, line: line, column: column, funcName: funcName)
    }
    
    static func out(message: String, logLevel: LogLevel, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        guard logLevel.rawValue >= Log.logLevel.rawValue else {
            return
        }
        #if DEBUG
        print("\(Date().toString()) [\(sourceFileName(filePath: fileName))(\(line):\(column))] \(funcName) -> \(logLevel.string)\(message)")
        #endif
    }

    private static func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
