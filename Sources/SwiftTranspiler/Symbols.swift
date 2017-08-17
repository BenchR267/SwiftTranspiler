import ParserCombinator

let assign = string("=") ^^ { _ in Token.assign }

let symbol = assign
