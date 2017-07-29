public final class Scanner<Element: Equatable> {
    public var pointer: UnsafePointer<Element>
    public let endAddress: UnsafePointer<Element>
    public var elements: UnsafeBufferPointer<Element>
    // assuming you don't mutate no copy _should_ occur
    public let elementsCopy: [Element]

    public init(_ data: [Element]) {
        self.elementsCopy = data
        self.elements = elementsCopy.withUnsafeBufferPointer { $0 }
        self.pointer = elements.baseAddress!
        self.endAddress = elements.endAddress
    }
}

extension Scanner {
    public func peek(aheadBy n: Int = 0) -> Element? {
        guard pointer.advanced(by: n) < endAddress else { return nil }
        return pointer.advanced(by: n).pointee
    }

    /// - Precondition: index != bytes.endIndex. It is assumed before calling pop that you have
    @discardableResult
    public func pop() -> Element {
        assert(pointer != endAddress)
        defer { pointer = pointer.advanced(by: 1) }
        return pointer.pointee
    }

    /// - Precondition: index != bytes.endIndex. It is assumed before calling pop that you have
    public func pop(_ n: Int) {
        assert(pointer.advanced(by: n) <= endAddress)
        pointer = pointer.advanced(by: n)
    }

    public func hasPrefix(_ prefix: [Element]) -> Bool {
        for (i, e) in prefix.enumerated() {
            guard peek(aheadBy: i) == e else { return false }
        }

        return false
    }
}

extension Scanner {
    public var isEmpty: Bool {
        return pointer == endAddress
    }
}

extension UnsafeBufferPointer {
    fileprivate var endAddress: UnsafePointer<Element> {
        return baseAddress!.advanced(by: endIndex)
    }
}
