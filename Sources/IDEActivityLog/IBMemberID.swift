//
//  IBMemberID.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation

public class IBMemberID: XCLogParserModel {
    
    public var isParserInit: Bool = false
    
    public private(set) var memberIdentifier: String = ""

    required public init() {
        
    }
    
    required public init(parser: XCLogParser) throws {
        memberIdentifier = try parser.next().asString()
    }
    
    public static func subtypes() -> [String : XCLogParserModel.Type] {
        return [
            "IBMemberID" : IBMemberID.self
        ]
    }
}
