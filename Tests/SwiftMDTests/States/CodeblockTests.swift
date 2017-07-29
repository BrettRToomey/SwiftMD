import XCTest
@testable import SwiftMD

class CodeblockTests: XCTestCase {
    func testCodeblock() {
        let parser = "This is a codeblock\n".toParser()
        let node = parser.extractCodeblock()
        XCTAssertEqual(node.kind, AstKind.codeblock)

        if let codeblock = node.value as? AstNode.Codeblock {
            XCTAssertEqual(codeblock.body.count, 1)
            if let child = codeblock.body.first {
                XCTAssertEqual(String(bytes: child, encoding: .utf8), "This is a codeblock")
            }
        }
    }
}
