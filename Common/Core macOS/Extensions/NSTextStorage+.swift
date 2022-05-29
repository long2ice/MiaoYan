import Foundation

import Cocoa

public extension NSTextStorage {
    func updateFont() {
        beginEditing()
        enumerateAttribute(.font, in: NSRange(location: 0, length: self.length)) { value, range, _ in
            if let font = value as? NSFont {
                let newFontDescriptor = font.fontDescriptor
                    .withSymbolicTraits(font.fontDescriptor.symbolicTraits)

                if let newFont = NSFont(descriptor: newFontDescriptor, size: CGFloat(UserDefaultsManagement.fontSize)) {
                    removeAttribute(.font, range: range)
                    addAttribute(.font, value: newFont, range: range)
                    fixAttributes(in: range)
                }
            }
        }
        endEditing()
    }

    func updateParagraphStyle(range: NSRange? = nil) {
        let scanRange = range ?? NSRange(0 ..< length)

        if scanRange.length == 0 {
            return
        }
        beginEditing()

        let font = UserDefaultsManagement.noteFont
        let tabs = self.getTabStops()

        self.addTabStops(range: scanRange, tabs: tabs)

        let spaceWidth = " ".widthOfString(usingFont: font, tabs: tabs)

        enumerateAttribute(.attachment, in: scanRange, options: .init()) { _, range, _ in
            if attribute(.todo, at: range.location, effectiveRange: nil) != nil {
                let parRange = mutableString.paragraphRange(for: NSRange(location: range.location, length: 0))
                let parStyle = NSMutableParagraphStyle()
                parStyle.headIndent = font.pointSize + font.pointSize / 2 + spaceWidth
                parStyle.lineSpacing = CGFloat(UserDefaultsManagement.editorLineSpacing)
                self.addAttribute(.paragraphStyle, value: parStyle, range: parRange)
            }
        }

        endEditing()
    }

    func addTabStops(range: NSRange, tabs: [NSTextTab]) {
        var paragraph = NSMutableParagraphStyle()
        let font = UserDefaultsManagement.noteFont

        mutableString.enumerateSubstrings(in: range, options: .byParagraphs) { value, parRange, _, _ in
            var parRange = parRange

            if let value = value,
               value.count > 1,

               value.starts(with: "    ")
               || value.starts(with: "\t")
               || value.starts(with: "* ")
               || value.starts(with: "- ")
               || value.starts(with: "+ ")
               || value.starts(with: "> ")
               || self.getNumberListPrefix(paragraph: value) != nil
            {
                let prefix = value.getSpacePrefix()
                let checkList = [
                    prefix + "* ",
                    prefix + "- ",
                    prefix + "+ ",
                    prefix + "> ",
                    "* ",
                    "- ",
                    "+ ",
                    "> "
                ]

                var result = String()
                for checkItem in checkList {
                    if value.starts(with: checkItem) {
                        result = checkItem
                        break
                    }
                }

                if let prefix = self.getNumberListPrefix(paragraph: value) {
                    result = prefix
                }

                let width = result.widthOfString(usingFont: font, tabs: tabs)

                paragraph = NSMutableParagraphStyle()
                paragraph.lineSpacing = CGFloat(UserDefaultsManagement.editorLineSpacing)
                paragraph.alignment = .left
                paragraph.headIndent = width
            } else {
                // Fixes new line size (proper line spacing)
                if parRange.length == 0, parRange.location > 0 {
                    parRange = NSRange(location: parRange.location, length: 1)
                }

                paragraph = NSMutableParagraphStyle()
                paragraph.lineSpacing = CGFloat(UserDefaultsManagement.editorLineSpacing)
                paragraph.alignment = .left
            }

            paragraph.tabStops = tabs

            self.addAttribute(.paragraphStyle, value: paragraph, range: parRange)
        }
    }

    func getTabStops() -> [NSTextTab] {
        var tabs = [NSTextTab]()
        let tabInterval = 40

        for index in 1 ... 25 {
            let tab = NSTextTab(textAlignment: .left, location: CGFloat(tabInterval * index), options: [:])
            tabs.append(tab)
        }

        return tabs
    }

    func getNumberListPrefix(paragraph: String) -> String? {
        var result = String()
        var numberFound = false
        var dotFound = false

        for char in paragraph {
            if char.isWhitespace {
                result.append(char)
                if dotFound, numberFound {
                    return result
                }
                continue
            } else if char.isNumber {
                numberFound = true
                result.append(char)
                continue
            } else if char == "." {
                if !numberFound {
                    return nil
                }
                dotFound = true
                result.append(char)
                continue
            }

            if !numberFound || !dotFound {
                return nil
            }
        }

        return nil
    }

    func sizeAttachmentImages() {
        enumerateAttribute(.attachment, in: NSRange(location: 0, length: self.length)) { value, range, _ in
            if let attachment = value as? NSTextAttachment,
               attribute(.todo, at: range.location, effectiveRange: nil) == nil
            {
                if let imageData = attachment.fileWrapper?.regularFileContents, var image = NSImage(data: imageData) {
                    if let rep = image.representations.first {
                        var maxWidth = UserDefaultsManagement.imagesWidth
                        if maxWidth == Float(1000) {
                            maxWidth = Float(rep.pixelsWide)
                        }

                        let ratio = Float(maxWidth) / Float(rep.pixelsWide)
                        var size = NSSize(width: rep.pixelsWide, height: rep.pixelsHigh)

                        if ratio < 1 {
                            size = NSSize(width: Int(maxWidth), height: Int(Float(rep.pixelsHigh) * Float(ratio)))
                        }

                        image = image.resize(to: size)!

                        let cell = NSTextAttachmentCell(imageCell: NSImage(size: size))
                        cell.image = image
                        attachment.attachmentCell = cell

                        addAttribute(.link, value: String(), range: range)
                    }
                }
            }
        }
    }
}
