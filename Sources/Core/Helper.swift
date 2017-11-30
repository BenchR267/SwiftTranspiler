//
//  Helper.swift
//  SwiftTranspiler
//
//  Created by Benjamin Herzog on 17.08.17.
//

import Parsel

public func string(_ v: String) -> Parser<String, String> {
    return Parser { str in
        guard str.hasPrefix(v) else {
            return .fail(LexerError.stringDoesNotMatch)
        }
        return .success(result: v, rest: String(str.dropFirst(v.count)))
    }
}
