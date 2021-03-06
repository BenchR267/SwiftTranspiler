import Core

public class Namelist {
    init(_ content: [String: IdentifierInformation] = [:]) {
        self.content = content
    }
    
    var content = [String: IdentifierInformation]()
    subscript(_ key: String) -> IdentifierInformation? {
        get { return self.content[key] }
        set { self.content[key] = newValue }
    }
}

public struct Program {
    public var scope: Scope
}

public struct IdentifierInformation {
    let type: String
    let mutable: Bool
}

public struct Scope {
    public var statements = [Statement]()

    // name: type
    // function parameters: _func_NAME_0, _func_NAME_1, ...
    public var namelist = [String: IdentifierInformation]()
}

public enum Statement {
    case declaration(Declaration)
    case controlStructure(ControlStructure)
    case expression(Expression)
    case assignment(Assignment)
    case returnE(Expression?)
}

public struct Assignment {
    public var identifer: Token
    public var expression: Expression
}

public enum Declaration {
    case function(FunctionDecl)
    case variable(VariableDecl)
    case constant(LetDecl)
}

public struct FunctionDecl {
    public var name: String
    public var parameters: [ParameterDecl]
    public var returnType: String
    public var body: FunctionBody
}

public struct FunctionBody {
    public var statements: [Statement]
}

public struct VariableDecl {
    public var parameter: ParameterDecl
}

public struct LetDecl {
    public var parameter: ParameterDecl
}

public struct ParameterDecl {
    public var name: String
    public var type: String
    public var expression: Expression?
}

public enum ControlStructure {
    case ifS(If)
    case forS(For)
    case whileS(While)
}

public struct If {
    // will be evaluated in order (if, else if, ...)
    public var conditions: [(MultipleCondition, Scope)]
    public var elseS: Scope?
}

public struct MultipleCondition {
    public var conditions: [Expression]
    public var operators: [Token]
}

public struct Condition {
    public var expr1: Expression
    public var operatorT: Token
    public var expr2: Expression
}

public struct For {
    // TODO
}

public struct While {
    public var expression: MultipleCondition
    public var scope: Scope
}

public struct Call {
    public var name: String
    public var parameters: [Expression]
}

public struct MultipleCalculation {
    public var expressions: [Expression]
    public var operators: [String]
}

public indirect enum Expression {
    case token(Token)
    case call(Call)
    case condition(Condition)
    case calculation(MultipleCalculation)

    public func type(_ namelist: Namelist) -> String {
        switch self {
        case .token(let token):
            switch token {
            case .literal(.string(_)):
                return "String"
            case .literal(.int(_)):
                return "Int"
            case .literal(.double(_)):
                return "Double"
            case .literal(.float(_)):
                return "Float"
            case .literal(.bool(_)):
                return "Bool"
            case let .identifier(name):
                return namelist[name]?.type ?? "Void"
            default:
                return "Void"
            }
        case .call(let call):
            return namelist[call.name]?.type ?? "Void"
        case .calculation(let c):
            return c.expressions.first?.type(namelist) ?? "Int"
        case .condition(_):
            return "Bool"
        }
    }
}



