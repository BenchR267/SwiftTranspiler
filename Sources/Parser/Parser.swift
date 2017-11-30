import ParserCombinator
import Core
import Lexer

func token(_ t: Token) -> Parser<[Token], Token> {
    return Parser { tokens in
        guard let first = tokens.first, first == t else {
            return .fail(ParserError.missingToken(t))
        }
        return .success(result: first, rest: Array(tokens.dropFirst()))
    }
}

let identifier = Parser<[Token], String> { tokens in
    guard case let .some(.identifier(name)) = tokens.first else {
        return .fail(ParserError.missingToken(.equal))
    }
    return .success(result: name, rest: Array(tokens.dropFirst()))
}

public let parameterDecl = ((identifier <~ token(.colon)) ~ identifier) ^^ ParameterDecl.init

public let letDecl = token(.keyword("let")) >~ parameterDecl
