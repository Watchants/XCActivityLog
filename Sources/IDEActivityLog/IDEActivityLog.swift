//
//  IDEActivityLog.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation

public class IDEActivityLog: XCLogParserModel {
    
    public var isParserInit: Bool = false
    
    public private(set) var version: UInt64 = 0
    public private(set) var section: IDEActivityLogSection = IDEActivityLogSection()

    required public init() {
        
    }
    
    required public init(parser: XCLogParser) throws {
        version = try parser.next().asInteger()
        section = try parser.parse(type: IDEActivityLogSection.self)
    }
    
    public static func subtypes() -> [String : XCLogParserModel.Type] {
        return ["IDEActivityLog": IDEActivityLog.self]
    }
    
}
