@testable import SwiftMD

extension String {
    func toParser() -> Parser {
        return Parser(Scanner([UInt8](utf8)))
    }
}
