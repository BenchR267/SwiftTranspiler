import XCTest
@testable import SwiftTranspiler

class SwiftTranspilerTests: XCTestCase {
    func testExample() throws {
        
        let input = """
let a = false
"""
        
        
        let tokens = swift.parse(input)
        print(">>> ", try tokens.unwrap(), " rest: ", try tokens.rest())
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
