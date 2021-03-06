// sourcery:inline:LinuxTests
@testable import SwiftMDTests
import XCTest

extension CodeblockTests {
    static var allTests = [
        ("testCodeblock", testCodeblock),
    ]
}

extension ExtractNodeTests {
    static var allTests = [
        ("testCodeblock", testCodeblock),
    ]
}

extension ParagraphTests {
    static var allTests = [
        ("testParagraph", testParagraph),
    ]
}

extension PotentialThematicBreakTests {
    static var allTests = [
        ("testThematicBreak", testThematicBreak),
        ("testThematicBreakCR", testThematicBreakCR),
        ("testThematicBreakCRLF", testThematicBreakCRLF),
        ("testThematicBreakAsterix", testThematicBreakAsterix),
        ("testThematicBreakUnderscore", testThematicBreakUnderscore),
        ("testThematicBreakWithIntermSpace", testThematicBreakWithIntermSpace),
        ("testThematicBreakWithMultipleIntermSpace", testThematicBreakWithMultipleIntermSpace),
        ("testThematicBreakWithTrailingSpaces", testThematicBreakWithTrailingSpaces),
        ("testThematicBreakWithMoreThanThreeChars", testThematicBreakWithMoreThanThreeChars),
        ("testThematicBreakWithMoreThanThreeCharsAndIntermSpace", testThematicBreakWithMoreThanThreeCharsAndIntermSpace),
        ("testThematicBreakWithMoreThanThreeCharsAndMultipleIntermSpaces", testThematicBreakWithMoreThanThreeCharsAndMultipleIntermSpaces),
        ("testDoesNotReturnHRForTwoChars", testDoesNotReturnHRForTwoChars),
        ("testMixedThematicBreaksDoesNotResultInThematicBreak", testMixedThematicBreaksDoesNotResultInThematicBreak),
        ("testInvalidCharDoesNotResultInThematicBreak", testInvalidCharDoesNotResultInThematicBreak),
        ("testThematicBreakDoesNotOverpeak", testThematicBreakDoesNotOverpeak),
        ("testThematicBreakDoesNotOverpeakCRLF", testThematicBreakDoesNotOverpeakCRLF),
    ]
}

extension WhitespaceTests {
    static var allTests = [
        ("testSpaceCount", testSpaceCount),
        ("testSpaceCountCR", testSpaceCountCR),
        ("testSpaceCountCRLF", testSpaceCountCRLF),
        ("testSpaceCountTab", testSpaceCountTab),
        ("testSpaceCountTabCR", testSpaceCountTabCR),
        ("testSpaceCountTabCRLF", testSpaceCountTabCRLF),
        ("testSpaceCountSpacesAndTabs", testSpaceCountSpacesAndTabs),
        ("testSpaceCountTabsAndSpaces", testSpaceCountTabsAndSpaces),
        ("testConsumeLine", testConsumeLine),
        ("testConsumeLineCR", testConsumeLineCR),
        ("testConsumeLineCRLF", testConsumeLineCRLF),
    ]
}

XCTMain([
    testCase(CodeblockTests.allTests),
    testCase(ExtractNodeTests.allTests),
    testCase(ParagraphTests.allTests),
    testCase(PotentialThematicBreakTests.allTests),
    testCase(WhitespaceTests.allTests),
])

// sourcery:end
