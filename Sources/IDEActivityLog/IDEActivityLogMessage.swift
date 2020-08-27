//
//  IDEActivityLogMessage.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation

public class IDEActivityLogMessage: XCLogParserModel {
    
    public var isParserInit: Bool = false
    
    public private(set) var title: String = ""
    public private(set) var shortTitle: String = ""
    public private(set) var timeEmitted: UInt64 = 0
    public private(set) var rangeEndInSectionText: UInt64 = 0
    public private(set) var rangeStartInSectionText: UInt64 = 0
    public private(set) var submessages: [IDEActivityLogMessage] = []
    public private(set) var severity: UInt64 = 0
    public private(set) var type: String = ""
    public private(set) var location: DVTDocumentLocation = DVTDocumentLocation()
    public private(set) var categoryIdent: String = ""
    public private(set) var secondaryLocations: [DVTDocumentLocation] = []
    public private(set) var additionalDescription: String = ""

    required public init() {
        
    }
    
    required public init(parser: XCLogParser) throws {
        title = try parser.next().asString()
        shortTitle = try parser.next().asString()
        timeEmitted = try parser.next().asInteger()
        rangeEndInSectionText = try parser.next().asInteger()
        rangeStartInSectionText = try parser.next().asInteger()
        submessages = try parser.parseItems(type: IDEActivityLogMessage.self)
        severity = try parser.next().asInteger()
        type = try parser.next().asString()
        location = try parser.parse(type: DVTDocumentLocation.self)
        categoryIdent = try parser.next().asString()
        secondaryLocations = try parser.parseItems(type: DVTDocumentLocation.self)
        additionalDescription = try parser.next().asString()
    }
    
    public static func subtypes() -> [String : XCLogParserModel.Type] {
        return [
            "IDEActivityLogMessage" : IDEActivityLogMessage.self,
            "IDEClangDiagnosticActivityLogMessage" : IDEClangDiagnosticActivityLogMessage.self,
            "IDEDiagnosticActivityLogMessage" : IDEDiagnosticActivityLogMessage.self,
            "IDEActivityLogAnalyzerResultMessage" : IDEActivityLogAnalyzerResultMessage.self,
            "IDEActivityLogAnalyzerControlFlowStepMessage" : IDEActivityLogAnalyzerControlFlowStepMessage.self,
            "IDEActivityLogAnalyzerEventStepMessage" : IDEActivityLogAnalyzerEventStepMessage.self,
        ]
    }
}

public class IDEClangDiagnosticActivityLogMessage: IDEActivityLogMessage {
    
}

public class IDEDiagnosticActivityLogMessage: IDEActivityLogMessage {
    
}

public class IDEActivityLogAnalyzerResultMessage: IDEActivityLogMessage {

    public var resultType: String = ""
    public var keyEventIndex: UInt64 = 0

    public required init() {
        super.init()
    }
    
    public required init(parser: XCLogParser) throws {
        try super.init(parser: parser)
        resultType = try parser.next().asString()
        keyEventIndex = try parser.next().asInteger()
    }
    
}

public class IDEActivityLogAnalyzerControlFlowStepMessage: IDEActivityLogMessage {

    public var parentIndex: UInt64 = 0
    public var endLocation: DVTDocumentLocation = DVTDocumentLocation()
    public var edges: [IDEActivityLogAnalyzerControlFlowStepEdge] = []

    public required init() {
        super.init()
    }
    
    public required init(parser: XCLogParser) throws {
        try super.init(parser: parser)
        parentIndex = try parser.next().asInteger()
        endLocation = try parser.parse(type: DVTDocumentLocation.self)
        edges = try parser.parseItems(type: IDEActivityLogAnalyzerControlFlowStepEdge.self)
    }
    
}

public class IDEActivityLogAnalyzerEventStepMessage: IDEActivityLogMessage {

    public var parentIndex: UInt64 = 0
    public var description: String = ""
    public var callDepth: UInt64 = 0

    public required init() {
        super.init()
    }
    
    public required init(parser: XCLogParser) throws {
        try super.init(parser: parser)
        parentIndex = try parser.next().asInteger()
        description = try parser.next().asString()
        callDepth = try parser.next().asInteger()
    }
    
}
