import ParserCombinator

private let parenthesisOpen = string("(") ^^ {_ in Token.parenthesisOpen}
private let parenthesisClose = string(")") ^^ {_ in Token.parenthesisClose}

private let curlyBracketOpen = string("{") ^^ {_ in Token.curlyBracketOpen}
private let curlyBracketClose = string("}") ^^ {_ in Token.curlyBracketClose}

private let squareBracketOpen = string("[") ^^ {_ in Token.squareBracketOpen}
private let squareBracketClose = string("]") ^^ {_ in Token.squareBracketClose}

private let logicalAnd = string("&&") ^^ {_ in Token.logicalAnd}
private let logicalOr = string("||") ^^ {_ in Token.logicalOr}
private let and = string("&") ^^ {_ in Token.and}
private let or = string("|") ^^ {_ in Token.or}

private let arrow = string("->") ^^ {_ in Token.arrow}
private let comma = string(",") ^^ {_ in Token.comma}
private let point = string(".") ^^ {_ in Token.point}
private let colon = string(":") ^^ {_ in Token.colon}

private let assign = string("=") ^^ {_ in Token.assign}
private let plusAssign = string("+=") ^^ {_ in Token.plusAssign}
private let minusAssign = string("-=") ^^ {_ in Token.minusAssign}

private let plus = string("+") ^^ {_ in Token.plus}
private let minus = string("-") ^^ {_ in Token.minus}
private let slash = string("/") ^^ {_ in Token.slash}
private let multiply = string("*") ^^ {_ in Token.multiply}
private let percent = string("%") ^^ {_ in Token.percent}

private let equal = string("==") ^^ {_ in Token.equal}
private let notEqual = string("!=") ^^ {_ in Token.notEqual}
private let greaterEqual = string(">=") ^^ {_ in Token.greaterEqual}
private let lessEqual = string("<=") ^^ {_ in Token.lessEqual}
private let greater = string(">") ^^ {_ in Token.greater}
private let less = string("<") ^^ {_ in Token.less}

private let questionMark = string("?") ^^ {_ in Token.questionMark}
private let bang = string("!") ^^ {_ in Token.bang}
private let underscore = string("_") ^^ {_ in Token.underscore}

private let others: [Parser<String, Token>] = [parenthesisClose, curlyBracketOpen, curlyBracketClose, squareBracketOpen, squareBracketClose, logicalAnd, logicalOr, and, or, arrow, comma, point, colon, assign, plusAssign, minusAssign, plus, minus, slash, multiply, percent, equal, notEqual, greaterEqual, lessEqual, greater, less, questionMark, bang, underscore]

let symbol = parenthesisOpen.or(others)
