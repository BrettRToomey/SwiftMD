public typealias Byte = UInt8
public typealias Bytes = [Byte]

public enum SpecialLine {
    case codeblock
    case emptyLine
}

extension Byte {
    public static let tab: Byte             = 0x09
    public static let newline: Byte         = 0x0A
    public static let carriageReturn: Byte  = 0x0D
    public static let space: Byte           = 0x20
    public static let dash: Byte            = 0x2D
    public static let asterix: Byte         = 0x2A
    public static let underscore: Byte      = 0x5F
}

public final class Parser {
    public let scanner: Scanner<Byte>

    public init(_ scanner: Scanner<Byte>) {
        self.scanner = scanner
    }
}

extension Parser {
    public static func parse(_ string: String) -> [AstNode] {
        return parse([UInt8](string.utf8))
    }

    public static func parse(_ bytes: Bytes) -> [AstNode] {
        let parser = Parser(Scanner(bytes))

        var nodes: [AstNode] = []
        while let node = parser.extractNode() {
            nodes.append(node)
        }

        return nodes
    }
}

extension Parser {
    public func extractNode() -> AstNode? {
        if getSpaceCount() >= 4 {
            return extractPotentialCodeblock() ?? extractNode()
        }

        guard let byte = scanner.peek() else { return nil}
        switch byte {
        case .dash, .asterix, .underscore:
            return extractPotentialThematicBreak()
        default:
            return extractParagraph()
        }
    }

    public func extractParagraph() -> AstNode? {
        // TODO(Brett): inline value detection and parsing

        var body: [InlineAstValue] = []
        while !isEmptyLine() {
            body.append(AstNode.RawText(body: consumeLine()))
        }

        if let byte = scanner.peek() {
            var bytesToCleanup = 1
            if byte == .carriageReturn {
                if scanner.peek(aheadBy: 1) == .newline {
                    bytesToCleanup += 1
                }
            }

            scanner.pop(bytesToCleanup)
        }

        return AstNode(value: AstNode.Paragraph(body: body))
    }

    public func extractPotentialThematicBreak() -> AstNode? {
        // A line consisting of 0-3 spaces of indentation, followed by a
        // sequence of three or more matching -, _, or * characters, each
        // followed optionally by any number of spaces, forms a thematic break.

        assert(scanner.peek() != nil)
        guard let byteWeAreLookingFor = scanner.peek() else { return nil }

        var count = 1
        var peeked = 1

        loop: while let byte = scanner.peek(aheadBy: peeked) {
            peeked += 1
            
            switch byte {
            case .space: break
            case byteWeAreLookingFor:
                count += 1

            case .newline:
                break loop

            case .carriageReturn:
                if scanner.peek(aheadBy: peeked) == .newline { peeked += 1}
                break loop
                
            default:
                return extractParagraph()
            }
        }

        guard count >= 3 else { return extractParagraph() }
        scanner.pop(peeked)
        return AstNode(value: AstNode.HorizontalRule())
    }

    public func extractPotentialCodeblock() -> AstNode? {
//        let start = scanner.pointer
        var count = 0
        var seenNonWhitespace = false
        while let byte = scanner.peek(aheadBy: count) {
            if byte == .newline {
                break
            }

            if byte == .carriageReturn {
                if scanner.peek(aheadBy: count + 1) == .newline {
                    count += 1
                }

                break
            }

            if byte != .space {
                if byte != .tab {
                    seenNonWhitespace = true
                }
            }

            count += 1
        }

        // empty line
        guard seenNonWhitespace else { return nil }

        return nil
    }
}

extension Parser {
    public func isEmptyLine() -> Bool {
        var peeked = 0
        while let byte = scanner.peek(aheadBy: peeked) {
            if byte == .newline || byte == .carriageReturn { continue }
            if byte != .space && byte != .tab { return false }
            peeked += 1
        }

        return true
    }

    public func getSpaceCount() -> Int {
        var count = 0
        var peeked = 0

        // Tabs in lines are not expanded to spaces. However, in contexts where
        // whitespace helps to define block structure, tabs behave as if they were
        // replaced by spaces with a tab stop of 4 characters.
        //
        // Thus, for example, a tab can be used instead of four spaces in an
        // indented code block. (Note, however, that internal tabs are passed
        // through as literal tabs, not expanded to spaces.)
        loop: while let byte = scanner.peek(aheadBy: peeked), count < 4 {
            switch byte {
            case .space:    count += 1
            case .tab:      count += 4
            default:        break loop
            }

            peeked += 1
        }

        scanner.pop(peeked)
        return count
    }

    internal func consumeLine() -> Bytes {
        let start = scanner.pointer
        var count = 0
        var cleanup = 1

        while let byte = scanner.peek(aheadBy: count) {
            if byte == .newline {
                break
            }

            if byte == .carriageReturn {
                // CRLF
                if scanner.peek(aheadBy: count + 1) == .newline { cleanup += 1 }
                break
            }

            count += 1
        }

        scanner.pop(count + cleanup)

        return Array(UnsafeBufferPointer(start: start, count: count))
    }
}
