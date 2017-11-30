import Parsel
import Core

let mapping: [(String, Token)] = [
    ("(", Token.parenthesisOpen),
    (")", Token.parenthesisClose),
    
    ("{", Token.curlyBracketOpen),
    ("}", Token.curlyBracketClose),
    
    ("[", Token.squareBracketOpen),
    ("]", Token.squareBracketClose),
    
    ("&&", Token.logicalAnd),
    ("||", Token.logicalOr),
    ("&", Token.and),
    ("|", Token.or),
    
    ("->", Token.arrow),
    (",", Token.comma),
    (".", Token.point),
    (":", Token.colon),
    
    ("=", Token.assign),
    ("+=", Token.plusAssign),
    ("-=", Token.minusAssign),
    
    ("+", Token.plus),
    ("-", Token.minus),
    ("/", Token.slash),
    ("*", Token.multiply),
    ("%", Token.percent),
    
    ("==", Token.equal),
    ("!=", Token.notEqual),
    (">=", Token.greaterEqual),
    ("<=", Token.lessEqual),
    (">", Token.greater),
    ("<", Token.less),
    
    ("?", Token.questionMark),
    ("!", Token.bang),
    ("_", Token.underscore)
]

let parsers = mapping.map { raw, token in
    return string(raw) ^^ { _ in token }
}

let symbol = parsers[0].or(parsers.dropFirst())
