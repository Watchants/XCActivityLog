//
//  XCLogParser.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation
import XCActivityLog

public final class XCLogParser {
    
    let filepath: String
    
    let SLF0: Bool
    let activityLog: XCActivityLogRef
    
    var ended: Bool
    var classes: [String]
    
    public init(filepath: String) {
        self.classes = []
        self.filepath = filepath
        self.activityLog = XCActivityLogCreate(filepath)
        self.SLF0 = XCActivityLogSLF0Head(activityLog)
        self.ended = false
    }
    
    deinit {
        XCActivityLogRelease(activityLog)
    }
    
    public func parseIDEActivityLog() throws -> IDEActivityLog {
        let model = try IDEActivityLog(parser: self)
        model.isParserInit = true
        return model
    }
    
    internal func parse<T: XCLogParserModel>(type: T.Type) throws -> T {
        let value = next()
        
        guard case .ClassInstance(let className) = value else {
            if case .Nil = value {
                return type.init()
            } else {
                throw XCLogParser.Error.parseValueError("Unexpected token found parsing \(type): \(value)")
            }
        }
        
        guard let subtype = type.subtypes()[className] else {
            throw XCLogParser.Error.parseValueError("Unexpected className found parsing \(type): \(className)")
        }
        
        var model = try subtype.init(parser: self) as! T
        model.isParserInit = true
        return model
    }
    
    internal func parseItems<T: XCLogParserModel>(type: T.Type) throws -> [T] {
        let value = next()
        switch value {
        case .Nil:
            return []
        case .Array(let count):
            var items = [T]()
            for _ in 0..<count {
                let item = try parse(type: type)
                items.append(item)
            }
            return items
        default:
            throw XCLogParser.Error.parseValueError("Unexpected token parsing array of \(type): \(value)")
        }
    }
    
}
