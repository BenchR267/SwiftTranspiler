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
let b = 5
let a: Int = b
"""
        let namelist = Namelist()
        
        let a = lexer.map(letDecl(namelist: namelist).rep.parse)
        
        print(">>> ", try a.parse(input).unwrap())
        print(">>> ", namelist.content)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
