//
//  main.swift
//  Application
//
//  Created by panghu on 9/20/20.
//

import Foundation
import XCActivityLog
import IDEActivityLog

do {
    let time1 = CFAbsoluteTimeGetCurrent()
    let parser = XCLogParser(filepath: "/Users/panghu/Downloads/A16DA26A-CA3C-4CA5-B0A3-70816B9A6CF9.xcactivitylog")
    let mode = try parser.parseIDEActivityLog()
    let time2 = CFAbsoluteTimeGetCurrent()

    print(mode)
    print(time2 - time1)
} catch {
    print(error)
}
