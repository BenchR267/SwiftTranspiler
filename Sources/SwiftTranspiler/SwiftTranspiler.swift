import ParserCombinator

enum LexerError: UInt64, ParseError {
    case stringDoesNotMatch
}

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
    case space
    case tab
    case newLine
}

let identifier = "[a-zA-Z_][a-zA-Z0-9_]*".r ^^ { Token.identifier($0) }

let literal = /* Double */ ("-?[0-9]+(\\.[0-9]+)?".r) ^^ { Token.literal(.double(Double($0)!)) } |
              /* Int    */ ("-?[0-9]+".r ^^ { Token.literal(.int(Int($0)!)) }) |
              /* Bool   */ ((string("true") | string("false")) ^^ { Token.literal(.bool($0 == "true")) }) |
              /* String */ (string("\"") >~ "[^\"]*".r <~ string("\"")) ^^ { Token.literal(.string($0)) }



let swift = (symbol | keyword | literal | identifier).rep(sep: "[\\s]*".r)
