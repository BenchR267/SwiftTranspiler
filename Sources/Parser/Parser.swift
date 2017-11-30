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

let expression: Parser<[Token], Expression> =
    /* literal */    (literal ^^ { .token(.literal($0)) }) |
    /* identifier */ (identifier ^^ { .token(.identifier($0)) })

public func parameterDecl(namelist: Namelist) -> Parser<[Token], ParameterDecl> {
    return (identifier ~ (token(.colon) ~> identifier).optional ~ (token(.assign) ~> expression).optional).flatMap { r in
        let name = r.0
        let declaredType = r.1
        let expression = r.2
        
        if let declared = declaredType, let e = expression, declared == e.type(namelist) {
            return Parser<[Token], ParameterDecl>.just(ParameterDecl(name: name, type: declared, expression: expression))
        } else if let e = expression, declaredType == nil {
            return Parser<[Token], ParameterDecl>.just(ParameterDecl(name: name, type: e.type(namelist), expression: expression))
        } else if let declared = declaredType, expression == nil {
            return Parser<[Token], ParameterDecl>.just(ParameterDecl(name: name, type: declared, expression: expression))
        }
        
        return Parser.fail(error: ParserError.emptyInput)
    }
}

public func letDecl(namelist: Namelist) -> Parser<[Token], LetDecl> {
    return token(.keyword("let")) ~> parameterDecl(namelist: namelist) ^^ { p in
        namelist[p.name] = IdentifierInformation(type: p.type, mutable: false)
        return LetDecl(parameter: p)
    }
}
