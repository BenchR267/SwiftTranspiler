import XCTest
import Core
import Lexer
@testable import Parser

class SwiftTranspilerTests: XCTestCase {
    func testExample() throws {
        
        let input = """
// This will be awesome!
let a = false
func b(parameter: Int) -> Int {
    return 5 * parameter
}
"""
        
        
        let tokens = lexer.parse(input)
        
        let expected: [Token] = [
            .comment("// This will be awesome!"),
            .keyword("let"),
            .identifier("a"),
            .assign,
            .literal(.bool(false)),
            .keyword("func"),
            .identifier("b"),
            .parenthesisOpen,
            .identifier("parameter"),
            .colon,
            .identifier("Int"),
            .parenthesisClose,
            .arrow,
            .identifier("Int"),
            .curlyBracketOpen,
            .keyword("return"),
            .literal(.int(5)),
            .multiply,
            .identifier("parameter"),
            .curlyBracketClose]
        
        XCTAssertEqual(try tokens.unwrap(), expected)
        XCTAssertEqual(try tokens.rest(), "")
    }

    func test_parser() throws {
        let input = """
let a: Int = 4
"""
        let a = lexer.map(letDecl.parse)
        
        print(">>> ", try a.parse(input).unwrap())
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
