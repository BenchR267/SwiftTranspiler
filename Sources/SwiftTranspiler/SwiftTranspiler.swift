import ParserCombinator

enum LexerError: UInt64, ParseError {
    case stringDoesNotMatch
}

enum Token {
    enum Literal {
        case string(String)
        case int(Int)
    }
    
    case identifier(String)
    case literal(Literal)
    case letK
    case equal
}

let identifier = "[a-zA-Z_][a-zA-Z0-9_]*".r ^^ { Token.identifier($0) }

let literal = ("\"".r >~ "[^\"]*".r <~ "\"".r) ^^ { Token.literal(.string($0)) } |
              ("[0-9]+".r ^^ { Token.literal(.int(Int($0)!)) })

func string(_ v: String) -> Parser<String, String> {
    return Parser { str in
        guard str.hasPrefix(v) else {
            return .fail(LexerError.stringDoesNotMatch)
        }
        return .success(result: v, rest: String(str.dropFirst(v.count)))
    }
}

let letK = string("let") ^^ { _ in Token.letK }
let equal = string("=") ^^ { _ in Token.equal }

let keyword = letK | equal

let swift = (keyword | literal | identifier).rep(sep: " *".r)
