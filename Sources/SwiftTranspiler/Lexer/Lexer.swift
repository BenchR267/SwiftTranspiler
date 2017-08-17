import ParserCombinator

enum LexerError: UInt64, ParseError {
    case stringDoesNotMatch
}

let identifier = "[a-zA-Z_][a-zA-Z0-9_]*".r ^^ { Token.identifier($0) }

// all beside Float have their parsing structure
let literal = /* Int    */ ("-?[0-9]+".r ^^ { Token.literal(.int(Int($0)!)) }) |
              /* Double */ ("-?[0-9]+(\\.[0-9]+)?".r) ^^ { Token.literal(.double(Double($0)!)) } |
              /* Bool   */ ((string("true") | string("false")) ^^ { Token.literal(.bool($0 == "true")) }) |
              /* String */ (string("\"") >~ "[^\"]*".r <~ string("\"")) ^^ { Token.literal(.string($0)) }

let comment = "//.*\n".r ^^ { Token.comment(String($0.dropLast())) }

let lexer = (comment | symbol | keyword | literal | identifier).rep(sep: "[\\s]*".r)
