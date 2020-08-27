//
//  XCLogParserModel.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation

public protocol XCLogParserModel {
    
    var isParserInit: Bool { get set }
    
    init()
    
    init(parser: XCLogParser) throws
    
    static func subtypes() -> [String : XCLogParserModel.Type];
    
}
