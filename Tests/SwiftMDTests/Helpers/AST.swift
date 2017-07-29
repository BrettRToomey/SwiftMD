@testable import SwiftMD

// sourcery:inline:ASTEquatable
extension AstNode: Equatable {
    public static func ==(lhs: AstNode, rhs: AstNode) -> Bool {
        return lhs.kind == rhs.kind && lhs.value.cmp(rhs.value)
    }
}

extension AstValue {
    func cmp(_ rhs: AstValue) -> Bool {
        switch (self, rhs) {
        case (let a as AstNode.Blockquote, let b as AstNode.Blockquote):
            return true

        case (let a as AstNode.BoldText, let b as AstNode.BoldText):
            return true

        case (let a as AstNode.Codeblock, let b as AstNode.Codeblock):
            return true

        case (is AstNode.HorizontalRule, is AstNode.HorizontalRule):
            return true

        case (let a as AstNode.ItalicText, let b as AstNode.ItalicText):
            return true

        case (let a as AstNode.Paragraph, let b as AstNode.Paragraph):
            return true

        case (let a as AstNode.RawText, let b as AstNode.RawText):
            return true

        default: return false
        }
    }
}
// sourcery:end
