import XCTest
@testable import SwiftMD

class WhitespaceTests: XCTestCase {
    func testSpaceCount() {
        let parser = "    \n".toParser()
        let count = parser.getSpaceCount()
        XCTAssertEqual(count, 4)
        XCTAssertEqual(parser.scanner.peek(), Byte.newline)
    }

    func testSpaceCountCR() {
        let parser = "    \r".toParser()
        let count = parser.getSpaceCount()
        XCTAssertEqual(count, 4)
        XCTAssertEqual(parser.scanner.peek(), Byte.carriageReturn)
    }

    func testSpaceCountCRLF() {
        let parser = "    \r\n".toParser()
        let count = parser.getSpaceCount()
        XCTAssertEqual(count, 4)
        XCTAssertEqual(parser.scanner.peek(), Byte.carriageReturn)
        XCTAssertEqual(parser.scanner.peek(aheadBy: 1), Byte.newline)
    }

    func testSpaceCountTab() {
        let parser = "\t\n".toParser()
        let count = parser.getSpaceCount()
        XCTAssertEqual(count, 4)
        XCTAssertEqual(parser.scanner.peek(), Byte.newline)
    }

    func testSpaceCountTabCR() {
        let parser = "\t\r".toParser()
        let count = parser.getSpaceCount()
        XCTAssertEqual(count, 4)
        XCTAssertEqual(parser.scanner.peek(), Byte.carriageReturn)
    }

    func testSpaceCountTabCRLF() {
        let parser = "\t\r\n".toParser()
        let count = parser.getSpaceCount()
        XCTAssertEqual(count, 4)
        XCTAssertEqual(parser.scanner.peek(), Byte.carriageReturn)
        XCTAssertEqual(parser.scanner.peek(aheadBy: 1), Byte.newline)
    }

    func testSpaceCountSpacesAndTabs() {
        let parser = "    \t\n".toParser()
        let count = parser.getSpaceCount()
        XCTAssertEqual(count, 4)
        XCTAssertEqual(parser.scanner.peek(), Byte.tab)
    }

    func testSpaceCountTabsAndSpaces() {
        let parser = "\t    \n".toParser()
        let count = parser.getSpaceCount()
        XCTAssertEqual(count, 4)
        XCTAssertEqual(parser.scanner.peek(), Byte.space)
    }

    func testConsumeLine() {
        let parser = "Hello, world!\n".toParser()
        let substringBytes = parser.consumeLine()
        let substring = String(bytes: substringBytes, encoding: .utf8)
        XCTAssertEqual(substring, "Hello, world!")
        XCTAssertNil(parser.scanner.peek())
    }

    func testConsumeLineCR() {
        let parser = "Hello, world!\r".toParser()
        let substringBytes = parser.consumeLine()
        let substring = String(bytes: substringBytes, encoding: .utf8)
        XCTAssertEqual(substring, "Hello, world!")
        XCTAssertNil(parser.scanner.peek())
    }

    func testConsumeLineCRLF() {
        let parser = "Hello, world!\r\n".toParser()
        let substringBytes = parser.consumeLine()
        let substring = String(bytes: substringBytes, encoding: .utf8)
        XCTAssertEqual(substring, "Hello, world!")
        XCTAssertNil(parser.scanner.peek())
    }
}
