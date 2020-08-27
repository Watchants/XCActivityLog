//
//  DVTDocumentLocation.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation

public class DVTDocumentLocation: XCLogParserModel {
    
    public var isParserInit: Bool = false
        
    public private(set) var documentURLString: String = ""
    public private(set) var timestamp: Double = 0

    required public init() {
        
    }
    
    required public init(parser: XCLogParser) throws {
        documentURLString = try parser.next().asString()
        timestamp = try parser.next().asFloatingPoint()
    }
    
    public static func subtypes() -> [String : XCLogParserModel.Type] {
        return [
            "DVTDocumentLocation" : DVTDocumentLocation.self,
            "Xcode3ProjectDocumentLocation" : Xcode3ProjectDocumentLocation.self,
            "IDELogDocumentLocation" : IDELogDocumentLocation.self,
            "DVTTextDocumentLocation" : DVTTextDocumentLocation.self,
            "IBDocumentMemberLocation" : DVTTextDocumentLocation.self,
        ]
    }
}

public class Xcode3ProjectDocumentLocation: DVTDocumentLocation {
    
}

public class IDELogDocumentLocation: DVTDocumentLocation {
    
}

public class DVTTextDocumentLocation: DVTDocumentLocation {
    
    public var startingLineNumber: UInt64 = 0
    public var startingColumnNumber: UInt64 = 0
    public var endingLineNumber: UInt64 = 0
    public var endingColumnNumber: UInt64 = 0
    public var characterRangeEnd: UInt64 = 0
    public var characterRangeStart: UInt64 = 0
    public var locationEncoding: UInt64 = 0

    public required init() {
        super.init()
    }
    
    public required init(parser: XCLogParser) throws {
        try super.init(parser: parser)
        startingLineNumber = try parser.next().asInteger()
        startingColumnNumber = try parser.next().asInteger()
        endingLineNumber = try parser.next().asInteger()
        endingColumnNumber = try parser.next().asInteger()
        characterRangeEnd = try parser.next().asInteger()
        characterRangeStart = try parser.next().asInteger()
        locationEncoding = try parser.next().asInteger()
    }
    
}

public class IBDocumentMemberLocation: DVTDocumentLocation {
    
    public var memberIdentifier: IBMemberID = IBMemberID()
    public var attributeSearchLocation: IBAttributeSearchLocation = IBAttributeSearchLocation()

    public required init() {
        super.init()
    }
    
    public required init(parser: XCLogParser) throws {
        try super.init(parser: parser)
        memberIdentifier = try parser.parse(type: IBMemberID.self)
        attributeSearchLocation = try parser.parse(type: IBAttributeSearchLocation.self)
    }
    
}
