public final class AstNode {
    public var kind: AstKind {
        return type(of: value).kind
    }

    public var value: AstValue

    public init(value: AstValue) {
        self.value = value
    }
}

public enum AstKind {
    case text
    case boldText
    case italicText
    case paragraph
    case blockquote
    case codeblock
    case horizontalRule
}

public protocol AstValue {
    static var kind: AstKind { get }
}

public protocol InlineAstValue: AstValue {
    var body: Bytes { get }
}

extension AstNode {
    public struct RawText: InlineAstValue {
        public static let kind = AstKind.text

        public let body: Bytes
    }

    public struct BoldText: InlineAstValue {
        public static let kind = AstKind.boldText

        public let body: Bytes
    }

    public struct ItalicText: InlineAstValue {
        public static let kind = AstKind.italicText

        public let body: Bytes
    }

    public struct Paragraph: AstValue {
        public static let kind = AstKind.paragraph

        public let body: [InlineAstValue]
    }

    public struct Codeblock: AstValue {
        public static let kind = AstKind.codeblock

        public let body: Bytes
    }

    public struct Blockquote: AstValue {
        public static let kind = AstKind.blockquote
        public let body: [InlineAstValue]
    }

    public struct HorizontalRule: AstValue {
        public static let kind = AstKind.horizontalRule
    }
}
