// NativeKit - Cross-platform view and color extensions

import Foundation

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

// MARK: - NSView Extensions

extension NSView {
    public var nkBackgroundColor: NSColor? {
        get { layer?.backgroundColor.flatMap { NSColor(cgColor: $0) } }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }

    public var nkCornerRadius: CGFloat {
        get { layer?.cornerRadius ?? 0 }
        set {
            wantsLayer = true
            layer?.cornerRadius = newValue
        }
    }

    public var nkBorderWidth: CGFloat {
        get { layer?.borderWidth ?? 0 }
        set {
            wantsLayer = true
            layer?.borderWidth = newValue
        }
    }

    public var nkBorderColor: NSColor? {
        get { layer?.borderColor.flatMap { NSColor(cgColor: $0) } }
        set {
            wantsLayer = true
            layer?.borderColor = newValue?.cgColor
        }
    }

    public func nkAddSubview(_ view: NSView) {
        addSubview(view)
    }

    public func nkRemoveFromSuperview() {
        removeFromSuperview()
    }
}

// MARK: - NSColor Extensions

extension NSColor {
    public static var nkLabel: NSColor { .labelColor }
    public static var nkSecondaryLabel: NSColor { .secondaryLabelColor }
    public static var nkTertiaryLabel: NSColor { .tertiaryLabelColor }
    public static var nkBackground: NSColor { .windowBackgroundColor }
    public static var nkSecondaryBackground: NSColor { .controlBackgroundColor }
    public static var nkSeparator: NSColor { .separatorColor }
    public static var nkAccent: NSColor { .controlAccentColor }

    public convenience init(nkRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// MARK: - NSTextField Label Factory

extension NSTextField {
    public static func nkLabel(text: String) -> NSTextField {
        let label = NSTextField(labelWithString: text)
        label.isEditable = false
        label.isSelectable = false
        label.isBordered = false
        label.backgroundColor = .clear
        return label
    }
}

// MARK: - NSFont Extensions

extension NSFont {
    public static func nkSystem(size: CGFloat, weight: NSFont.Weight = .regular) -> NSFont {
        .systemFont(ofSize: size, weight: weight)
    }

    public static func nkMonospaced(size: CGFloat, weight: NSFont.Weight = .regular) -> NSFont {
        .monospacedSystemFont(ofSize: size, weight: weight)
    }
}

// MARK: - NSImage Extensions

extension NSImage {
    public static func nkSystemImage(named name: String) -> NSImage? {
        NSImage(systemSymbolName: name, accessibilityDescription: nil)
    }
}

#elseif canImport(UIKit)

// MARK: - UIView Extensions

extension UIView {
    public var nkBackgroundColor: UIColor? {
        get { backgroundColor }
        set { backgroundColor = newValue }
    }

    public var nkCornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    public var nkBorderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    public var nkBorderColor: UIColor? {
        get { layer.borderColor.flatMap { UIColor(cgColor: $0) } }
        set { layer.borderColor = newValue?.cgColor }
    }

    public func nkAddSubview(_ view: UIView) {
        addSubview(view)
    }

    public func nkRemoveFromSuperview() {
        removeFromSuperview()
    }
}

// MARK: - UIColor Extensions

extension UIColor {
    public static var nkLabel: UIColor { .label }
    public static var nkSecondaryLabel: UIColor { .secondaryLabel }
    public static var nkTertiaryLabel: UIColor { .tertiaryLabel }
    public static var nkBackground: UIColor { .systemBackground }
    public static var nkSecondaryBackground: UIColor { .secondarySystemBackground }
    public static var nkSeparator: UIColor { .separator }
    public static var nkAccent: UIColor { .tintColor }

    public convenience init(nkRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// MARK: - UILabel Factory

extension UILabel {
    public static func nkLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }
}

// MARK: - UIFont Extensions

extension UIFont {
    public static func nkSystem(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        .systemFont(ofSize: size, weight: weight)
    }

    public static func nkMonospaced(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        .monospacedSystemFont(ofSize: size, weight: weight)
    }
}

// MARK: - UIImage Extensions

extension UIImage {
    public static func nkSystemImage(named name: String) -> UIImage? {
        UIImage(systemName: name)
    }
}

#endif
