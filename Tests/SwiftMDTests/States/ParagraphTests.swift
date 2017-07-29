import XCTest
@testable import SwiftMD

class ParagraphTests: XCTestCase {
    func testParagraph() {
        let parser = "This is a paragraph\n".toParser()
        let node = parser.extractParagraph()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.paragraph)

        if let paragraph = node?.value as? AstNode.Paragraph {
            XCTAssertEqual(paragraph.body.count, 1)
            if let child = paragraph.body.first {
                XCTAssertEqual(type(of: child).kind, AstKind.text)
                XCTAssertEqual(String(bytes: child.body, encoding: .utf8), "This is a paragraph")
            }
        }
    }
}
