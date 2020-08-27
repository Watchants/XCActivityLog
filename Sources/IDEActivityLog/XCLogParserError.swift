//
//  XCLogParserError.swift
//  IDEActivityLog
//
//  Created by panghu on 9/20/20.
//

import Foundation

extension XCLogParser {
    
    public enum Error: LocalizedError {
        
        case parseValueError(String)
        
        public var errorDescription: String? { return description }
        
    }
    
}

extension XCLogParser.Error: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .parseValueError(let message):
            return "Error parsing the log: \(message)"
        }
    }
    
}
