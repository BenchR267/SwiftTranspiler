import XCTest
@testable import SwiftTranspiler

class SwiftTranspilerTests: XCTestCase {
    func testExample() throws {
        
        let input = """
// This will be awesome!
let a = false
func b(parameter: Int) -> Int {
    return 5 * parameter
}
"""
        
        
        let tokens = swift.parse(input)
        print(">>> ", try tokens.unwrap(), " rest: ", try tokens.rest())
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
