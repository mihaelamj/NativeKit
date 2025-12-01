// NativeKit.LayoutDirection.swift
// NativeKit
//
// Cross-platform RTL (Right-to-Left) layout support utilities.
// Provides unified API for handling layout direction in AppKit and UIKit.

import Foundation

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
#elseif canImport(UIKit)
#endif

// MARK: - Layout Direction

extension NativeKit {
    /// Represents the layout direction for UI content.
    public enum LayoutDirection: Sendable {
        case leftToRight
        case rightToLeft

        /// Returns true if this is a right-to-left direction.
        public var isRTL: Bool {
            self == .rightToLeft
        }

        /// Returns true if this is a left-to-right direction.
        public var isLTR: Bool {
            self == .leftToRight
        }

        /// Returns the opposite direction.
        public var flipped: LayoutDirection {
            isRTL ? .leftToRight : .rightToLeft
        }
    }
}

/// Backwards compatibility alias
public typealias LayoutDirection = NativeKit.LayoutDirection

// MARK: - Layout Direction Detection

/// Utilities for detecting and working with layout direction.
@MainActor
public enum LayoutDirectionManager {

    /// Returns the current application layout direction based on the user's locale.
    public static var currentDirection: LayoutDirection {
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        return NSApp?.userInterfaceLayoutDirection == .rightToLeft ? .rightToLeft : .leftToRight
        #elseif canImport(UIKit)
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .rightToLeft : .leftToRight
        #endif
    }

    /// Returns true if the current layout direction is RTL.
    public static var isRTL: Bool {
        currentDirection.isRTL
    }

    /// Returns true if the current layout direction is LTR.
    public static var isLTR: Bool {
        currentDirection.isLTR
    }

    /// Returns the layout direction for a specific view.
    #if canImport(AppKit) && !targetEnvironment(macCatalyst)
    public static func direction(for view: NSView) -> LayoutDirection {
        view.userInterfaceLayoutDirection == .rightToLeft ? .rightToLeft : .leftToRight
    }
    #elseif canImport(UIKit)
    public static func direction(for view: UIView) -> LayoutDirection {
        UIView.userInterfaceLayoutDirection(for: view.semanticContentAttribute) == .rightToLeft ? .rightToLeft : .leftToRight
    }
    #endif

    /// Returns the layout direction for the given locale (thread-safe, no MainActor required).
    nonisolated public static func direction(for locale: Locale) -> LayoutDirection {
        guard let languageCode = locale.language.languageCode?.identifier else {
            return .leftToRight
        }
        return Locale.Language(identifier: languageCode).characterDirection == .rightToLeft ? .rightToLeft : .leftToRight
    }

    /// Returns true if the given language code is RTL (thread-safe, no MainActor required).
    nonisolated public static func isRTL(languageCode: String) -> Bool {
        // Common RTL language codes
        let rtlLanguages: Set<String> = [
            "ar", // Arabic
            "he", // Hebrew
            "fa", // Farsi/Persian
            "ur", // Urdu
            "yi", // Yiddish
            "ps", // Pashto
            "sd", // Sindhi
            "ug", // Uyghur
            "ku", // Kurdish (Arabic script)
            "dv", // Divehi
            "ckb" // Central Kurdish
        ]
        return rtlLanguages.contains(languageCode.lowercased())
    }
}

// MARK: - Platform View Extensions

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
extension NSView {

    /// The effective layout direction for this view.
    public var effectiveLayoutDirection: LayoutDirection {
        LayoutDirectionManager.direction(for: self)
    }

    /// Configures the view for the current layout direction.
    /// Call this in viewDidLoad or after adding subviews.
    public func configureForLayoutDirection() {
        // NSView automatically handles RTL through userInterfaceLayoutDirection
        // But subclasses may need additional configuration
        needsLayout = true
    }
}

extension NSViewController {

    /// The effective layout direction for this view controller's view.
    public var effectiveLayoutDirection: LayoutDirection {
        view.effectiveLayoutDirection
    }

    /// Configures the view controller for the current layout direction.
    public func configureForLayoutDirection() {
        view.configureForLayoutDirection()
    }
}

#elseif canImport(UIKit)
extension UIView {

    /// The effective layout direction for this view.
    public var effectiveLayoutDirection: LayoutDirection {
        LayoutDirectionManager.direction(for: self)
    }

    /// Configures the view for automatic RTL flipping.
    /// Call this after setting up the view hierarchy.
    public func configureForLayoutDirection() {
        // .unspecified allows the system to determine based on locale
        semanticContentAttribute = .unspecified
        setNeedsLayout()
    }

    /// Forces the view to use a specific layout direction.
    public func forceLayoutDirection(_ direction: LayoutDirection) {
        semanticContentAttribute = direction.isRTL ? .forceRightToLeft : .forceLeftToRight
        setNeedsLayout()
    }

    /// Forces the view to ignore layout direction (always LTR).
    /// Use for elements that should never flip, like playback controls.
    public func forceLTR() {
        semanticContentAttribute = .playback
        setNeedsLayout()
    }

    /// Forces the view to use spatial semantics (never flip).
    /// Use for elements with fixed spatial meaning, like maps.
    public func forceSpatial() {
        semanticContentAttribute = .spatial
        setNeedsLayout()
    }
}

extension UIViewController {

    /// The effective layout direction for this view controller's view.
    public var effectiveLayoutDirection: LayoutDirection {
        view.effectiveLayoutDirection
    }

    /// Configures the view controller's view for automatic RTL flipping.
    public func configureForLayoutDirection() {
        view.configureForLayoutDirection()
    }

    /// Forces the view controller to use a specific layout direction.
    public func forceLayoutDirection(_ direction: LayoutDirection) {
        view.forceLayoutDirection(direction)
    }
}

extension UIStackView {

    /// Configures the stack view for proper RTL behavior.
    /// This ensures items are arranged correctly based on layout direction.
    public func configureForRTL() {
        semanticContentAttribute = .unspecified

        // Horizontal stacks need semantic content attribute to flip
        if axis == .horizontal {
            // The stack view will automatically reverse item order in RTL
            // when semanticContentAttribute is .unspecified
        }
    }
}
#endif

// MARK: - Geometry Utilities

extension LayoutDirection {

    /// Flips an X coordinate within a given width for RTL.
    /// Use for manual drawing operations that need to respect layout direction.
    public func flipX(_ x: CGFloat, in width: CGFloat) -> CGFloat {
        isRTL ? width - x : x
    }

    /// Flips a point horizontally within a given width for RTL.
    public func flipPoint(_ point: CGPoint, in width: CGFloat) -> CGPoint {
        CGPoint(x: flipX(point.x, in: width), y: point.y)
    }

    /// Flips a rect horizontally within a given width for RTL.
    public func flipRect(_ rect: CGRect, in width: CGFloat) -> CGRect {
        guard isRTL else { return rect }
        return CGRect(
            x: width - rect.maxX,
            y: rect.origin.y,
            width: rect.width,
            height: rect.height
        )
    }

    /// Returns the leading edge X coordinate for a rect.
    /// In LTR this is minX, in RTL this is maxX.
    public func leadingX(of rect: CGRect) -> CGFloat {
        isRTL ? rect.maxX : rect.minX
    }

    /// Returns the trailing edge X coordinate for a rect.
    /// In LTR this is maxX, in RTL this is minX.
    public func trailingX(of rect: CGRect) -> CGFloat {
        isRTL ? rect.minX : rect.maxX
    }

    /// Returns the leading inset from a set of edge insets.
    #if canImport(UIKit)
    public func leadingInset(from insets: UIEdgeInsets) -> CGFloat {
        isRTL ? insets.right : insets.left
    }

    /// Returns the trailing inset from a set of edge insets.
    public func trailingInset(from insets: UIEdgeInsets) -> CGFloat {
        isRTL ? insets.left : insets.right
    }
    #endif

    /// Returns directional edge insets from standard edge insets.
    #if canImport(UIKit)
    public func directionalInsets(from insets: UIEdgeInsets) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(
            top: insets.top,
            leading: leadingInset(from: insets),
            bottom: insets.bottom,
            trailing: trailingInset(from: insets)
        )
    }
    #endif
}

// MARK: - Connection Point Utilities

/// Utilities for calculating connection points in node-based UIs.
/// These properly handle RTL by using semantic "leading" and "trailing" concepts.
public struct ConnectionPointCalculator {

    public let layoutDirection: LayoutDirection

    /// Creates a calculator with the specified layout direction.
    /// Use `LayoutDirectionManager.currentDirection` from a MainActor context to get the current direction.
    public init(layoutDirection: LayoutDirection = .leftToRight) {
        self.layoutDirection = layoutDirection
    }

    /// Creates a calculator using the current application layout direction.
    /// Must be called from MainActor context.
    @MainActor
    public static func current() -> ConnectionPointCalculator {
        ConnectionPointCalculator(layoutDirection: LayoutDirectionManager.currentDirection)
    }

    /// Returns the output connection point for a node (trailing edge, vertically centered).
    /// In LTR this is the right edge, in RTL this is the left edge.
    public func outputPoint(for frame: CGRect) -> CGPoint {
        CGPoint(
            x: layoutDirection.trailingX(of: frame),
            y: frame.midY
        )
    }

    /// Returns the input connection point for a node (leading edge, vertically centered).
    /// In LTR this is the left edge, in RTL this is the right edge.
    public func inputPoint(for frame: CGRect) -> CGPoint {
        CGPoint(
            x: layoutDirection.leadingX(of: frame),
            y: frame.midY
        )
    }

    /// Returns control points for a bezier curve connecting two nodes.
    /// The curve properly handles RTL by flowing in the correct direction.
    public func bezierControlPoints(from startPoint: CGPoint, to endPoint: CGPoint) -> (cp1: CGPoint, cp2: CGPoint) {
        let deltaX = abs(endPoint.x - startPoint.x)
        let controlOffset = max(deltaX * 0.5, 50)

        let cp1: CGPoint
        let cp2: CGPoint

        if layoutDirection.isRTL {
            // In RTL, connections flow right-to-left
            cp1 = CGPoint(x: startPoint.x - controlOffset, y: startPoint.y)
            cp2 = CGPoint(x: endPoint.x + controlOffset, y: endPoint.y)
        } else {
            // In LTR, connections flow left-to-right
            cp1 = CGPoint(x: startPoint.x + controlOffset, y: startPoint.y)
            cp2 = CGPoint(x: endPoint.x - controlOffset, y: endPoint.y)
        }

        return (cp1, cp2)
    }
}

// MARK: - Image Flipping

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
extension NSImage {

    /// Returns a horizontally flipped copy of the image for RTL support.
    public func flippedHorizontally() -> NSImage {
        let flipped = NSImage(size: size)
        flipped.lockFocus()

        let transform = NSAffineTransform()
        transform.translateX(by: size.width, yBy: 0)
        transform.scaleX(by: -1, yBy: 1)
        transform.concat()

        draw(at: .zero, from: NSRect(origin: .zero, size: size), operation: .sourceOver, fraction: 1.0)

        flipped.unlockFocus()
        return flipped
    }

    /// Returns this image or a flipped version based on layout direction.
    public func imageForLayoutDirection(_ direction: NativeKit.LayoutDirection) -> NSImage {
        direction.isRTL ? flippedHorizontally() : self
    }
}
#elseif canImport(UIKit)
extension UIImage {

    /// Returns a horizontally flipped copy of the image for RTL support.
    public func flippedHorizontally() -> UIImage {
        guard let cgImage = cgImage else { return self }
        return UIImage(cgImage: cgImage, scale: scale, orientation: .upMirrored)
    }

    /// Returns this image or a flipped version based on layout direction.
    public func imageForLayoutDirection(_ direction: NativeKit.LayoutDirection) -> UIImage {
        direction.isRTL ? flippedHorizontally() : self
    }

    /// Returns an image configured to flip automatically in RTL.
    public func imageWithRTLSupport() -> UIImage {
        imageFlippedForRightToLeftLayoutDirection()
    }
}
#endif

// MARK: - SF Symbols RTL Support

/// Helpers for SF Symbols that need special RTL handling.
public enum DirectionalSymbols {

    /// Returns the appropriate SF Symbol name for a "forward" action.
    /// In LTR this points right, in RTL this points left.
    public static func forwardArrow(for direction: LayoutDirection) -> String {
        direction.isRTL ? "arrow.left" : "arrow.right"
    }

    /// Returns the appropriate SF Symbol name for a "backward" action.
    public static func backwardArrow(for direction: LayoutDirection) -> String {
        direction.isRTL ? "arrow.right" : "arrow.left"
    }

    /// Returns the appropriate SF Symbol name for "next" navigation.
    public static func nextChevron(for direction: LayoutDirection) -> String {
        direction.isRTL ? "chevron.left" : "chevron.right"
    }

    /// Returns the appropriate SF Symbol name for "previous" navigation.
    public static func previousChevron(for direction: LayoutDirection) -> String {
        direction.isRTL ? "chevron.right" : "chevron.left"
    }

    /// Returns the appropriate SF Symbol name for "expand" disclosure.
    public static func disclosureIndicator(for direction: LayoutDirection) -> String {
        direction.isRTL ? "chevron.left" : "chevron.right"
    }

    /// Returns the appropriate SF Symbol name for text alignment "leading".
    public static func alignLeading(for direction: LayoutDirection) -> String {
        direction.isRTL ? "text.alignright" : "text.alignleft"
    }

    /// Returns the appropriate SF Symbol name for text alignment "trailing".
    public static func alignTrailing(for direction: LayoutDirection) -> String {
        direction.isRTL ? "text.alignleft" : "text.alignright"
    }

    /// Symbols that should NEVER flip (playback, spatial meaning).
    public static let nonFlippingSymbols: Set<String> = [
        "play.fill",
        "pause.fill",
        "stop.fill",
        "backward.fill",
        "forward.fill",
        "gobackward",
        "goforward",
        "speaker.wave.1",
        "speaker.wave.2",
        "speaker.wave.3"
    ]
}
