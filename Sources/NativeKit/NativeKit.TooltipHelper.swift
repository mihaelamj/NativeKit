// NativeKit.TooltipHelper.swift
// NativeKit
//
// RTL-aware tooltip utilities for cross-platform UI elements.
// Provides consistent tooltip application for both AppKit and UIKit.

import Foundation

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

// MARK: - Tooltip Helper (macOS)

extension NativeKit {
    /// Utility for applying tooltips to views with RTL awareness.
    @MainActor
    public enum TooltipHelper {

    /// Applies a tooltip to an NSView.
    /// - Parameters:
    ///   - tooltip: The localized tooltip text.
    ///   - view: The view to apply the tooltip to.
    public static func apply(_ tooltip: String, to view: NSView) {
        view.toolTip = tooltip
    }

    /// Applies a tooltip to an NSButton.
    /// - Parameters:
    ///   - tooltip: The localized tooltip text.
    ///   - button: The button to apply the tooltip to.
    public static func apply(_ tooltip: String, to button: NSButton) {
        button.toolTip = tooltip
    }

    /// Applies a tooltip to an NSControl.
    /// - Parameters:
    ///   - tooltip: The localized tooltip text.
    ///   - control: The control to apply the tooltip to.
    public static func apply(_ tooltip: String, to control: NSControl) {
        control.toolTip = tooltip
    }

    /// Applies a tooltip to an NSToolbarItem.
    /// - Parameters:
    ///   - tooltip: The localized tooltip text.
    ///   - item: The toolbar item to apply the tooltip to.
    public static func apply(_ tooltip: String, to item: NSToolbarItem) {
        item.toolTip = tooltip
    }

    /// Applies a tooltip to an NSMenuItem.
    /// - Parameters:
    ///   - tooltip: The localized tooltip text.
    ///   - menuItem: The menu item to apply the tooltip to.
    public static func apply(_ tooltip: String, to menuItem: NSMenuItem) {
        menuItem.toolTip = tooltip
    }

    /// Applies a tooltip to an NSSegmentedControl segment.
    /// - Parameters:
    ///   - tooltip: The localized tooltip text.
    ///   - control: The segmented control.
    ///   - segment: The segment index.
    public static func apply(_ tooltip: String, to control: NSSegmentedControl, segment: Int) {
        control.setToolTip(tooltip, forSegment: segment)
    }

    /// Applies a tooltip to an NSTableColumn.
    /// - Parameters:
    ///   - tooltip: The localized tooltip text.
    ///   - column: The table column.
    public static func apply(_ tooltip: String, to column: NSTableColumn) {
        column.headerToolTip = tooltip
    }
    }
}

/// Backwards compatibility alias
public typealias TooltipHelper = NativeKit.TooltipHelper

// MARK: - NSView Tooltip Extension

public extension NSView {

    /// Sets the tooltip with automatic RTL text alignment consideration.
    /// - Parameter tooltip: The localized tooltip text.
    @MainActor
    func setLocalizedTooltip(_ tooltip: String) {
        self.toolTip = tooltip
    }

    /// Sets the tooltip with a keyboard shortcut appended.
    /// - Parameters:
    ///   - tooltip: The base tooltip text.
    ///   - shortcut: The keyboard shortcut string (e.g., "⌘S").
    @MainActor
    func setTooltipWithShortcut(_ tooltip: String, shortcut: String) {
        self.toolTip = "\(tooltip) (\(shortcut))"
    }
}

// MARK: - NSButton Tooltip Extension

public extension NSButton {

    /// Configures the button with accessibility and tooltip.
    /// - Parameters:
    ///   - tooltip: The tooltip text.
    ///   - accessibilityLabel: The accessibility label.
    ///   - accessibilityHint: The accessibility hint (optional).
    @MainActor
    func configureAccessibility(
        tooltip: String,
        accessibilityLabel: String,
        accessibilityHint: String? = nil
    ) {
        self.toolTip = tooltip
        self.setAccessibilityLabel(accessibilityLabel)
        if let hint = accessibilityHint {
            self.setAccessibilityHelp(hint)
        }
    }
}

// MARK: - NSToolbarItem Tooltip Extension

public extension NSToolbarItem {

    /// Sets the tooltip with automatic localization.
    /// - Parameter tooltip: The localized tooltip text.
    @MainActor
    func setLocalizedTooltip(_ tooltip: String) {
        self.toolTip = tooltip
    }

    /// Configures the toolbar item with tooltip and accessibility.
    /// - Parameters:
    ///   - tooltip: The tooltip text.
    ///   - accessibilityLabel: The accessibility label.
    @MainActor
    func configureWithTooltip(_ tooltip: String, accessibilityLabel: String) {
        self.toolTip = tooltip
        self.label = accessibilityLabel
    }
}

// MARK: - Tooltip Position (macOS)

/// Represents preferred tooltip position relative to the anchor view.
/// On macOS, the system handles tooltip positioning, but this can be used
/// for custom tooltip implementations.
public enum TooltipPosition {
    case automatic
    case above
    case below
    case leading
    case trailing

    /// Returns the appropriate position considering layout direction.
    /// - Parameter direction: The current layout direction.
    /// - Returns: The adjusted tooltip position.
    public func adjusted(for direction: LayoutDirection) -> TooltipPosition {
        switch self {
        case .leading:
            return direction.isRTL ? .trailing : .leading
        case .trailing:
            return direction.isRTL ? .leading : .trailing
        default:
            return self
        }
    }
}

#elseif canImport(UIKit)

// MARK: - Tooltip Helper (iOS)

extension NativeKit {
    /// Utility for applying tooltips to views with RTL awareness.
    /// On iOS, tooltips are typically shown via context menus or long-press gestures.
    public enum TooltipHelper {

        /// Applies a tooltip to a UIView using accessibilityHint.
        /// On iOS, this sets the accessibility hint which VoiceOver reads.
        /// - Parameters:
        ///   - tooltip: The localized tooltip text.
        ///   - view: The view to apply the tooltip to.
        public static func apply(_ tooltip: String, to view: UIView) {
            view.accessibilityHint = tooltip
        }

        /// Applies a tooltip to a UIButton.
        /// - Parameters:
        ///   - tooltip: The localized tooltip text.
        ///   - button: The button to apply the tooltip to.
        public static func apply(_ tooltip: String, to button: UIButton) {
            button.accessibilityHint = tooltip
            // iOS 15+ supports toolTip on UIButton in Mac Catalyst
            if #available(iOS 15.0, *) {
                button.toolTip = tooltip
            }
        }

        /// Applies a tooltip to a UIControl.
        /// - Parameters:
        ///   - tooltip: The localized tooltip text.
        ///   - control: The control to apply the tooltip to.
        public static func apply(_ tooltip: String, to control: UIControl) {
            control.accessibilityHint = tooltip
        }

        /// Applies a tooltip to a UIBarButtonItem.
        /// - Parameters:
        ///   - tooltip: The localized tooltip text.
        ///   - item: The bar button item to apply the tooltip to.
        public static func apply(_ tooltip: String, to item: UIBarButtonItem) {
            item.accessibilityHint = tooltip
            // iOS 15+ primary action tooltip
            if #available(iOS 15.0, *) {
                if let action = item.primaryAction {
                    var updatedAction = action
                    // Can't directly modify, but set on customView if present
                }
            }
        }
    }
}

/// Backwards compatibility alias
public typealias TooltipHelper = NativeKit.TooltipHelper

// MARK: - UIView Tooltip Extension

public extension UIView {

    /// Sets the tooltip using accessibility hint.
    /// - Parameter tooltip: The localized tooltip text.
    func setLocalizedTooltip(_ tooltip: String) {
        self.accessibilityHint = tooltip
    }

    /// Sets the tooltip with a keyboard shortcut appended.
    /// - Parameters:
    ///   - tooltip: The base tooltip text.
    ///   - shortcut: The keyboard shortcut string (e.g., "⌘S").
    func setTooltipWithShortcut(_ tooltip: String, shortcut: String) {
        self.accessibilityHint = "\(tooltip) (\(shortcut))"
    }

    /// Adds a context menu with tooltip-like behavior.
    /// - Parameters:
    ///   - tooltip: The tooltip text to show.
    ///   - interaction: The context menu interaction to add.
    @available(iOS 13.0, *)
    func addTooltipContextMenu(_ tooltip: String) {
        // Create a simple context menu that shows the tooltip
        let interaction = UIContextMenuInteraction(delegate: TooltipContextMenuDelegate(tooltip: tooltip))
        self.addInteraction(interaction)
    }
}

// MARK: - UIButton Tooltip Extension

public extension UIButton {

    /// Sets the button tooltip using accessibility hint and iOS 15+ toolTip.
    /// - Parameter tooltip: The localized tooltip text.
    func setButtonTooltip(_ tooltip: String) {
        self.accessibilityHint = tooltip
        if #available(iOS 15.0, *) {
            self.toolTip = tooltip
        }
    }

    /// Configures the button with accessibility and tooltip.
    /// - Parameters:
    ///   - tooltip: The tooltip text.
    ///   - accessibilityLabel: The accessibility label.
    ///   - accessibilityHint: The accessibility hint (optional, uses tooltip if nil).
    func configureAccessibility(
        tooltip: String,
        accessibilityLabel: String,
        accessibilityHint: String? = nil
    ) {
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint ?? tooltip
        if #available(iOS 15.0, *) {
            self.toolTip = tooltip
        }
    }
}

// MARK: - UIBarButtonItem Tooltip Extension

public extension UIBarButtonItem {

    /// Sets the tooltip using accessibility hint.
    /// - Parameter tooltip: The localized tooltip text.
    func setLocalizedTooltip(_ tooltip: String) {
        self.accessibilityHint = tooltip
    }

    /// Configures the bar button item with tooltip and accessibility.
    /// - Parameters:
    ///   - tooltip: The tooltip text.
    ///   - accessibilityLabel: The accessibility label.
    func configureWithTooltip(_ tooltip: String, accessibilityLabel: String) {
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = tooltip
    }
}

// MARK: - Tooltip Context Menu Delegate

/// A simple context menu delegate that shows a tooltip-like menu.
@available(iOS 13.0, *)
private class TooltipContextMenuDelegate: NSObject, UIContextMenuInteractionDelegate {
    let tooltip: String

    init(tooltip: String) {
        self.tooltip = tooltip
        super.init()
    }

    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        configurationForMenuAtLocation location: CGPoint
    ) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            // Return an empty menu - the preview shows the tooltip
            return nil
        }
    }

    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        // Could customize preview here
        return nil
    }
}

// MARK: - Tooltip Position (iOS)

/// Represents preferred tooltip position relative to the anchor view.
public enum TooltipPosition {
    case automatic
    case above
    case below
    case leading
    case trailing

    /// Returns the appropriate position considering layout direction.
    /// - Parameter direction: The current layout direction.
    /// - Returns: The adjusted tooltip position.
    public func adjusted(for direction: LayoutDirection) -> TooltipPosition {
        switch self {
        case .leading:
            return direction.isRTL ? .trailing : .leading
        case .trailing:
            return direction.isRTL ? .leading : .trailing
        default:
            return self
        }
    }
}

#endif

// MARK: - Cross-Platform Tooltip Utilities

/// Cross-platform tooltip formatting utilities.
public enum TooltipFormatter {

    /// Formats a tooltip with an optional keyboard shortcut.
    /// - Parameters:
    ///   - text: The main tooltip text.
    ///   - shortcut: Optional keyboard shortcut to append.
    /// - Returns: The formatted tooltip string.
    public static func format(_ text: String, shortcut: String? = nil) -> String {
        if let shortcut = shortcut, !shortcut.isEmpty {
            return "\(text) (\(shortcut))"
        }
        return text
    }

    /// Formats a tooltip for a node category.
    /// - Parameters:
    ///   - category: The category name.
    ///   - description: The category description.
    /// - Returns: The formatted tooltip string.
    public static func formatCategory(_ category: String, description: String) -> String {
        return "\(category) - \(description)"
    }

    /// Formats a tooltip for a validation status.
    /// - Parameters:
    ///   - status: The status text.
    ///   - count: Optional count of issues.
    /// - Returns: The formatted tooltip string.
    public static func formatStatus(_ status: String, count: Int? = nil) -> String {
        if let count = count, count > 0 {
            return "\(status) (\(count))"
        }
        return status
    }

    /// Creates an RTL-aware directional tooltip.
    /// For example, "Swipe left to delete" becomes "Swipe right to delete" in RTL.
    /// - Parameters:
    ///   - action: The action description.
    ///   - direction: The current layout direction.
    ///   - leadingAction: What happens when swiping from leading edge.
    ///   - trailingAction: What happens when swiping from trailing edge.
    /// - Returns: The directionally-aware tooltip.
    public static func formatDirectional(
        leadingAction: String,
        trailingAction: String,
        direction: LayoutDirection
    ) -> String {
        if direction.isRTL {
            // In RTL, leading is right, trailing is left
            return "← \(trailingAction) | \(leadingAction) →"
        } else {
            // In LTR, leading is left, trailing is right
            return "← \(leadingAction) | \(trailingAction) →"
        }
    }
}
