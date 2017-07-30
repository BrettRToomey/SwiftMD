import XCTest
@testable import SwiftMD

class PotentialThematicBreakTests: XCTestCase {
    func testThematicBreak() {
        let parser = "---\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.horizontalRule)
        XCTAssertNil(parser.scanner.peek())
    }

    func testThematicBreakCR() {
        let parser = "---\r".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.horizontalRule)
        XCTAssertNil(parser.scanner.peek())
    }

    func testThematicBreakCRLF() {
        let parser = "---\r\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.horizontalRule)
        XCTAssertNil(parser.scanner.peek())
    }

    func testThematicBreakAsterix() {
        let parser = "***\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.horizontalRule)
        XCTAssertNil(parser.scanner.peek())
    }

    func testThematicBreakUnderscore() {
        let parser = "___\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.horizontalRule)
    }

    func testThematicBreakWithIntermSpace() {
        let parser = "* * *\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.horizontalRule)
    }

    func testThematicBreakWithMultipleIntermSpace() {
        let parser = "_    _    _\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.horizontalRule)
    }

    func testThematicBreakWithTrailingSpaces() {
        let parser = "___    \n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.horizontalRule)
    }

    func testThematicBreakWithMoreThanThreeChars() {
        let parser = "------\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.horizontalRule)
    }

    func testThematicBreakWithMoreThanThreeCharsAndIntermSpace() {
        let parser = "* * * * * *\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.horizontalRule)
    }

    func testThematicBreakWithMoreThanThreeCharsAndMultipleIntermSpaces() {
        let parser = "*   *   *   *   *   *\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(node)
        XCTAssertEqual(node?.kind, AstKind.horizontalRule)
    }

    func testDoesNotReturnHRForTwoChars() {
        let parser = "__\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotEqual(node?.kind, AstKind.horizontalRule)
    }

    func testMixedThematicBreaksDoesNotResultInThematicBreak() {
        let parser = "*-*\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotEqual(node?.kind, AstKind.horizontalRule)
    }

    func testInvalidCharDoesNotResultInThematicBreak() {
        let parser = "--A-\n".toParser()
        let node = parser.extractPotentialThematicBreak()
        XCTAssertNotEqual(node?.kind, AstKind.horizontalRule)
    }

    func testThematicBreakDoesNotOverpeak() {
        let parser = "---\n ".toParser()
        _ = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(parser.scanner.peek())
        XCTAssertEqual(parser.scanner.peek(), .space)
    }

    func testThematicBreakDoesNotOverpeakCRLF() {
        let parser = "---\r\n ".toParser()
        _ = parser.extractPotentialThematicBreak()
        XCTAssertNotNil(parser.scanner.peek())
        XCTAssertEqual(parser.scanner.peek(), .space)
    }
}
