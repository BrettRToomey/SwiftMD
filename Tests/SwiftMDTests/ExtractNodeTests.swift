import XCTest
@testable import SwiftMD

class ExtractNodeTests: XCTestCase {
    func testCodeblock() {
        let parser = "\n    This is a codeblock\n".toParser()
        let node = parser.extractNode()
        XCTAssertEqual(node?.kind, AstKind.codeblock)

        if let codeblock = node?.value as? AstNode.Codeblock {
            XCTAssertEqual(codeblock.body.count, 1)
            if let child = codeblock.body.first {
                XCTAssertEqual(String(bytes: child, encoding: .utf8), "This is a codeblock")
            }
        }
    }
}

