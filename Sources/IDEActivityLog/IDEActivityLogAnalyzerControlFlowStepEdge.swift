//
//  IDEActivityLogAnalyzerControlFlowStepEdge.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation

public class IDEActivityLogAnalyzerControlFlowStepEdge: XCLogParserModel {
    
    public var isParserInit: Bool = false
    
    public private(set) var startLocation: DVTDocumentLocation = DVTDocumentLocation()
    public private(set) var endLocation: DVTDocumentLocation = DVTDocumentLocation()

    required public init() {
        
    }
    
    required public init(parser: XCLogParser) throws {
        startLocation = try parser.parse(type: DVTDocumentLocation.self)
        endLocation = try parser.parse(type: DVTDocumentLocation.self)
    }
    
    public static func subtypes() -> [String : XCLogParserModel.Type] {
        return ["IDEActivityLogAnalyzerControlFlowStepEdge": IDEActivityLogAnalyzerControlFlowStepEdge.self]
    }
    
}
