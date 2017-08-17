import ParserCombinator

let letK = string("let") ^^ { Token.keyword($0) }


let keyword = letK
