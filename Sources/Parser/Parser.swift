import Parsel
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

let literal = Parser<[Token], Token.LiteralType> { tokens in
    guard let first = tokens.first else {
        return .fail(ParserError.emptyInput)
    }
    switch first {
    case .literal(let l):
        return .success(result: l, rest: Array(tokens.dropFirst()))
    default:
        return .fail(ParserError.unexpectedToken(expected: "Literal", got: first))
    }
}

let expression = literal ^^ { Expression.token(Token.literal($0)) }

public let parameterDecl = identifier <~ token(.colon) ~ identifier ^^ ParameterDecl.init

public let letDecl = token(.keyword("let")) ~> parameterDecl ~ (token(.assign) ~> expression) ^^ { LetDecl(parameter: $0, expression: $1) }
