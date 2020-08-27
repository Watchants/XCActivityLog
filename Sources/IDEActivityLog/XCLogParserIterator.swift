//
//  XCLogParserIterator.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation
import XCActivityLog

extension XCLogParser {
    
    public enum Iterator {
        case NotSLF0
        case Unknown
        case PointeeNil
        case Ended
        case Integer(UInt64)
        case FloatingPoint(Double)
        case Nil
        case String(String)
        case Array(UInt64)
        case ClassName(String)
        case ClassInstance(String)
    }
    
    public func next() -> Iterator {
        
        guard SLF0 else {
            return .NotSLF0
        }
        guard !ended else {
            return .Ended
        }
        
        let itemRef = XCActivityLogNextItem(activityLog)
        defer {
            XCActivityLogReleaseItem(itemRef)
        }
        
        guard let item = itemRef?.pointee else {
            return .PointeeNil
        }
        
        switch item.type {
        case XCActivityLogItemEnded:
            ended = true
            return .Ended
        case XCActivityLogItemInteger:
            return .Integer(item.number)
        case XCActivityLogItemFloatingPoint:
            return .FloatingPoint(item.floatingPoint)
        case XCActivityLogItemNil:
            return .Nil
        case XCActivityLogItemString:
            return .String(String(cString: item.text))
        case XCActivityLogItemArray:
            return .Array(item.number)
        case XCActivityLogItemClassName:
            let className = String(cString: item.text)
            classes.append(className)
            // return .ClassName(className)
            return next()
        case XCActivityLogItemClassInstance:
            return .ClassInstance(classes[Int(item.number - 1)])
        default:
            return .Unknown
        }
        
    }

}

extension XCLogParser.Iterator {
    
    public func asInteger() throws -> UInt64 {
        switch self {
        case .Integer(let value):
            return value
        default:
            throw XCLogParser.Error.parseValueError("Unexpected token parsing Integer: \(self))")
        }
    }
    
    public func asFloatingPoint() throws -> Double {
        switch self {
        case .FloatingPoint(let value):
            return value
        default:
            throw XCLogParser.Error.parseValueError("Unexpected token parsing FloatingPoint: \(self))")
        }
    }
    
    public func asString() throws -> String {
        switch self {
        case .String(let value):
            return value
        case .Nil:
            return ""
        default:
            throw XCLogParser.Error.parseValueError("Unexpected token parsing String: \(self))")
        }
    }
    
    public func asBoolean() throws -> Bool {
        switch self {
        case .Integer(let value):
            if value > 1 {
                throw XCLogParser.Error.parseValueError("Unexpected value parsing Boolean: \(value)")
            }
            return value == 1
        default:
            throw XCLogParser.Error.parseValueError("Unexpected token parsing Boolean: \(self))")
        }
    }
    
}
