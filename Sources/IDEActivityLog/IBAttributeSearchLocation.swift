//
//  IBAttributeSearchLocation.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation

public class IBAttributeSearchLocation: XCLogParserModel {
    
    public var isParserInit: Bool = false
    
    public private(set) var offsetFromStart: UInt64 = 0
    public private(set) var offsetFromEnd: UInt64 = 0
    public private(set) var keyPath: String = ""

    required public init() {
        
    }
    
    required public init(parser: XCLogParser) throws {
        offsetFromStart = try parser.next().asInteger()
        offsetFromEnd = try parser.next().asInteger()
        keyPath = try parser.next().asString()
    }
    
    public static func subtypes() -> [String : XCLogParserModel.Type] {
        return [
            "IBAttributeSearchLocation" : IBAttributeSearchLocation.self
        ]
    }
}
