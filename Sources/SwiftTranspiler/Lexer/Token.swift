import ParserCombinator

public enum LiteralType {
    case int(Int)
    case string(String)
    case double(Double)
    case float(Float)
    case bool(Bool)
}

public enum Token {
    case identifier(String)
    case keyword(String)
    case parenthesisOpen
    case parenthesisClose
    case curlyBracketOpen
    case curlyBracketClose
    case squareBracketOpen
    case squareBracketClose
    case questionMark
    case bang
    case underscore
    case and
    case or
    case logicalAnd
    case logicalOr
    case arrow
    case comma
    case point
    case colon
    case assign
    case plusAssign
    case minusAssign
    case plus
    case minus
    case slash
    case multiply
    case percent
    case equal
    case notEqual
    case greater
    case less
    case greaterEqual
    case lessEqual
    case literal(LiteralType)
    case comment(String)
    case illegal
}


extension Token: Equatable {
    
    public static func ==(lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case (.identifier, .identifier): return true
        case (.keyword, .keyword): return true
        case (.parenthesisOpen, .parenthesisOpen): return true
        case (.parenthesisClose, .parenthesisClose): return true
        case (.curlyBracketOpen, .curlyBracketOpen): return true
        case (.curlyBracketClose, .curlyBracketClose): return true
        case (.squareBracketOpen, .squareBracketOpen): return true
        case (.squareBracketClose, .squareBracketClose): return true
        case (.questionMark, .questionMark): return true
        case (.bang, .bang): return true
        case (.underscore, .underscore): return true
        case (.and, .and): return true
        case (.or, .or): return true
        case (.logicalAnd, .logicalAnd): return true
        case (.logicalOr, .logicalOr): return true
        case (.arrow, .arrow): return true
        case (.comma, .comma): return true
        case (.point, .point): return true
        case (.colon, .colon): return true
        case (.assign, .assign): return true
        case (.plusAssign, .plusAssign): return true
        case (.minusAssign, .minusAssign): return true
        case (.plus, .plus): return true
        case (.minus, .minus): return true
        case (.slash, .slash): return true
        case (.multiply, .multiply): return true
        case (.percent, .percent): return true
        case (.equal, .equal): return true
        case (.notEqual, .notEqual): return true
        case (.greater, .greater): return true
        case (.less, .less): return true
        case (.greaterEqual, .greaterEqual): return true
        case (.lessEqual, .lessEqual): return true
        case (.illegal, .illegal): return true
        case (.literal(.int(let i)), .literal(.int(let j))): return i == j
        case (.literal(.string(let a)), .literal(.string(let b))): return a == b
        case (.literal(.double(let a)), .literal(.double(let b))): return a == b
        case (.literal(.float(let a)), .literal(.float(let b))): return a == b
        case (.literal(.bool(let a)), .literal(.bool(let b))): return a == b
        case (.comment(let a), .comment(let b)): return a == b
        default: return false
        }
    }
    
}
