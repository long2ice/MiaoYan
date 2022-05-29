import CommonCrypto
import Foundation

#if os(OSX)
    import Cocoa
#else
    import UIKit
#endif

public extension String {
    #if os(OSX)
        typealias Font = NSFont
    #else
        typealias Font = UIFont
    #endif

    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }

    // Search the string for the existence of any of the terms in the provided array of terms.
    // Inspired by magic from https://stackoverflow.com/a/41902740/2778502
    func localizedStandardContains<S: StringProtocol>(_ terms: [S]) -> Bool {
        return terms.first(where: { self.localizedStandardContains($0) }) != nil
    }

    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }

    func getPrefixMatchSequentially(char: String) -> String? {
        var result = String()

        for current in self {
            if current.description == char {
                result += char
                continue
            }
            break
        }

        if result.count > 0 {
            return result
        }

        return nil
    }

    func localizedCaseInsensitiveContainsTerms(_ terms: [Substring]) -> Bool {
        // Use magic from https://stackoverflow.com/a/41902740/2778502
        return terms.first(where: { !self.localizedLowercase.contains($0) }) == nil
    }

    func removeLastNewLine() -> String {
        if self.last == "\n" {
            return String(self.dropLast())
        }

        return self
    }

    func isValidEmail() -> Bool {
        let pattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"

        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }

        return false
    }

    var isValidUUID: Bool {
        return UUID(uuidString: self) != nil
    }

    func escapePlus() -> String {
        return self.replacingOccurrences(of: "+", with: "%20")
    }

    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: [.dotMatchesLineSeparators]) else { return [] }

        let nsString = self as NSString
        let results = regex.matches(in: self, options: [], range: NSRange(0..<nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound
                    ? nsString.substring(with: result.range(at: $0))
                    : ""
            }
        }
    }

    func startsWith(string: String) -> Bool {
        guard let range = range(of: string, options: [.caseInsensitive, .diacriticInsensitive]) else {
            return false
        }
        return range.lowerBound == startIndex
    }

    func widthOfString(usingFont font: Font, tabs: [NSTextTab]? = nil) -> CGFloat {
        let paragraph = NSMutableParagraphStyle()
        if let tabs = tabs {
            paragraph.tabStops = tabs
        }

        let fontAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: paragraph
        ]

        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func getSpacePrefix() -> String {
        var prefix = String()
        for char in unicodeScalars {
            if char == "\t" || char == " " {
                prefix += String(char)
            } else {
                break
            }
        }
        return prefix
    }

    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }

    var isWhitespace: Bool {
        guard !isEmpty else { return true }

        let whitespaceChars = NSCharacterSet.whitespacesAndNewlines

        return self.unicodeScalars
            .filter { (unicodeScalar: UnicodeScalar) -> Bool in !whitespaceChars.contains(unicodeScalar) }
            .count == 0
    }

    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

public extension StringProtocol where Index == String.Index {
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}

public extension String {
    subscript(value: Int) -> Character {
        self[index(at: value)]
    }
}

public extension String {
    subscript(value: NSRange) -> Substring {
        self[value.lowerBound..<value.upperBound]
    }
}

public extension String {
    subscript(value: CountableClosedRange<Int>) -> Substring {
        self[index(at: value.lowerBound) ... index(at: value.upperBound)]
    }

    subscript(value: CountableRange<Int>) -> Substring {
        self[index(at: value.lowerBound)..<index(at: value.upperBound)]
    }

    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        self[..<index(at: value.upperBound)]
    }

    subscript(value: PartialRangeThrough<Int>) -> Substring {
        self[...index(at: value.upperBound)]
    }

    subscript(value: PartialRangeFrom<Int>) -> Substring {
        self[index(at: value.lowerBound)...]
    }
}

private extension String {
    func index(at offset: Int) -> String.Index {
        self.index(startIndex, offsetBy: offset)
    }
}
