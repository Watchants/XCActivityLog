//
//  IDEActivityLogSection.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation

public class IDEActivityLogSection: XCLogParserModel {
        
    public var isParserInit: Bool = false
    
    public private(set) var sectionType: UInt64 = 0
    public private(set) var domainType: String = ""
    public private(set) var title: String = ""
    public private(set) var signature: String = ""
    public private(set) var timeStartedRecording: Double = 0
    public private(set) var timeStoppedRecording: Double = 0
    public private(set) var subsections: [IDEActivityLogSection] = []
    public private(set) var text: String = ""
    public private(set) var messages: [IDEActivityLogMessage] = []
    public private(set) var wasCancelled: Bool = false
    public private(set) var isQuiet: Bool = false
    public private(set) var wasFetchedFromCache: Bool = false
    public private(set) var subtitle: String = ""
    public private(set) var location: DVTDocumentLocation = DVTDocumentLocation()
    public private(set) var commandDetailDesc: String = ""
    public private(set) var uniqueIdentifier: String = ""
    public private(set) var localizedResultString: String = ""
    public private(set) var xcbuildSignature: String = ""
    
    required public init() {
        
    }
    
    required public init(parser: XCLogParser) throws {
        sectionType = try parser.next().asInteger()
        domainType = try parser.next().asString()
        title = try parser.next().asString()
        signature = try parser.next().asString()
        timeStartedRecording = try parser.next().asFloatingPoint()
        timeStoppedRecording = try parser.next().asFloatingPoint()
        subsections = try parser.parseItems(type: IDEActivityLogSection.self)
        text = try parser.next().asString()
        messages = try parser.parseItems(type: IDEActivityLogMessage.self)
        wasCancelled = try parser.next().asBoolean()
        isQuiet = try parser.next().asBoolean()
        wasFetchedFromCache = try parser.next().asBoolean()
        subtitle = try parser.next().asString()
        location = try parser.parse(type: DVTDocumentLocation.self)
        commandDetailDesc = try parser.next().asString()
        uniqueIdentifier = try parser.next().asString()
        localizedResultString = try parser.next().asString()
        xcbuildSignature = try parser.next().asString()
    }
    
    public static func subtypes() -> [String : XCLogParserModel.Type] {
        return [
            "IDEActivityLogSection" : IDEActivityLogSection.self,
            "IDECommandLineBuildLog" : IDECommandLineBuildLog.self,
            "IDEActivityLogMajorGroupSection" : IDEActivityLogMajorGroupSection.self,
            "IDEActivityLogCommandInvocationSection" : IDEActivityLogCommandInvocationSection.self,
            "IDEActivityLogUnitTestSection" : IDEActivityLogUnitTestSection.self,
            "DBGConsoleLog" : DBGConsoleLog.self
        ]
    }
}

public class IDECommandLineBuildLog: IDEActivityLogSection {
    
}

public class IDEActivityLogMajorGroupSection: IDEActivityLogSection {
    
}

public class IDEActivityLogCommandInvocationSection: IDEActivityLogSection {
    
}

public class IDEActivityLogUnitTestSection: IDEActivityLogSection {
    
    public var testsPassedString: String = ""
    public var durationString: String = ""
    public var summaryString: String = ""
    public var suiteName: String = ""
    public var testName: String = ""
    public var performanceTestOutputString: String = ""

    public required init() {
        super.init()
    }
    
    public required init(parser: XCLogParser) throws {
        try super.init(parser: parser)
        testsPassedString = try parser.next().asString()
        durationString = try parser.next().asString()
        summaryString = try parser.next().asString()
        suiteName = try parser.next().asString()
        testName = try parser.next().asString()
        performanceTestOutputString = try parser.next().asString()
    }
}

public class DBGConsoleLog: IDEActivityLogSection {
    
    public var logConsoleItems: [IDEConsoleItem] = []
    
    public required init() {
        super.init()
    }
    
    public required init(parser: XCLogParser) throws {
        try super.init(parser: parser)
        logConsoleItems = try parser.parseItems(type: IDEConsoleItem.self)
    }
}
