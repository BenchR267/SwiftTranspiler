//
//  Helper.swift
//  SwiftTranspiler
//
//  Created by Benjamin Herzog on 17.08.17.
//

import Parsel

public enum LexerError: UInt64, ParseError {
    case stringDoesNotMatch
}

public enum ParserError: ParseError {
    case unexpectedToken(expected: String, got: Token)
    case missingToken(Token)
    
    public var code: UInt64 {
        switch self {
        case .unexpectedToken(_, _): return 0
        case .missingToken(_): return 1
        }
    }
}
