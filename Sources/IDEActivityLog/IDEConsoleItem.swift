//
//  IDEConsoleItem.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation

public class IDEConsoleItem: XCLogParserModel {
    
    public var isParserInit: Bool = false
    
    public private(set) var adaptorType: UInt64 = 0
    public private(set) var content: String = ""
    public private(set) var kind: UInt64 = 0
    public private(set) var timestamp: Double = 0

    required public init() {
        
    }
    
    required public init(parser: XCLogParser) throws {
        adaptorType = try parser.next().asInteger()
        content = try parser.next().asString()
        kind = try parser.next().asInteger()
        timestamp = try parser.next().asFloatingPoint()
    }
    
    public static func subtypes() -> [String : XCLogParserModel.Type] {
        return ["IDEConsoleItem" : IDEConsoleItem.self]
    }
    
}
