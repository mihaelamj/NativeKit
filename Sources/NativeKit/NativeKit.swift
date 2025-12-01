// NativeKit.swift
// NativeKit
//
// Root namespace for native UI components (AppKit + UIKit).
// Includes cross-platform type aliases and abstractions.
// Import NativeKit to get all AppKit/UIKit types without needing platform imports.

// Foundation: Core types (String, Data, URL, etc.) - available on all platforms
import Foundation

// Re-export the platform UI framework so consumers only need `import NativeKit`
// @_exported makes AppKit/UIKit types available to any file that imports NativeKit
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
@_exported import AppKit  // macOS native UI framework
#elseif canImport(UIKit)
@_exported import UIKit   // iOS/iPadOS/tvOS native UI framework
#endif

// MARK: - NativeKit

/// Root namespace for native UI components.
/// Contains cross-platform AppKit/UIKit implementations and platform abstractions.
public enum NativeKit {
    /// NativeKit version.
    public static let version = "1.0.0"
}

// MARK: - Platform Detection

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
public let isAppKit = true
public let isUIKit = false
#elseif canImport(UIKit)
public let isAppKit = false
public let isUIKit = true
#endif

// MARK: - Type Aliases

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

// MARK: - View Types
public typealias NKView = NSView
public typealias NKViewController = NSViewController
public typealias NKWindow = NSWindow
public typealias NKWindowController = NSWindowController
public typealias NKApplication = NSApplication
public typealias NKScreen = NSScreen
public typealias NKResponder = NSResponder

// MARK: - Application Instance
public var NKApp: NSApplication { NSApp }

// MARK: - Controls
public typealias NKControl = NSControl
public typealias NKButton = NSButton
public typealias NKLabel = NSTextField
public typealias NKTextField = NSTextField
public typealias NKTextView = NSTextView
public typealias NKSearchField = NSSearchField
public typealias NKSegmentedControl = NSSegmentedControl
public typealias NKSwitch = NSSwitch
public typealias NKSlider = NSSlider
public typealias NKPopUpButton = NSPopUpButton
public typealias NKColorWell = NSColorWell

// MARK: - Container Views
public typealias NKScrollView = NSScrollView
public typealias NKStackView = NSStackView
public typealias NKSplitViewController = NSSplitViewController
public typealias NKSplitViewItem = NSSplitViewItem
public typealias NKTabViewController = NSTabViewController
public typealias NKTabView = NSTabView
public typealias NKTabViewItem = NSTabViewItem

// MARK: - Table/Outline Views
public typealias NKTableView = NSTableView
public typealias NKTableColumn = NSTableColumn
public typealias NKTableCellView = NSTableCellView
public typealias NKOutlineView = NSOutlineView

// MARK: - Images & Graphics
public typealias NKImage = NSImage
public typealias NKImageView = NSImageView
public typealias NKColor = NSColor
public typealias NKFont = NSFont
public typealias NKBezierPath = NSBezierPath
public typealias NKGraphicsContext = NSGraphicsContext

// MARK: - Alerts & Panels
public typealias NKAlert = NSAlert
public typealias NKPanel = NSPanel
public typealias NKOpenPanel = NSOpenPanel
public typealias NKSavePanel = NSSavePanel

// MARK: - Events & Gestures
public typealias NKEvent = NSEvent
public typealias NKGestureRecognizer = NSGestureRecognizer
public typealias NKPanGestureRecognizer = NSPanGestureRecognizer
public typealias NKClickGestureRecognizer = NSClickGestureRecognizer
public typealias NKPressGestureRecognizer = NSPressGestureRecognizer
public typealias NKMagnificationGestureRecognizer = NSMagnificationGestureRecognizer

// MARK: - Drag & Drop
public typealias NKDraggingInfo = NSDraggingInfo
public typealias NKDraggingSession = NSDraggingSession
public typealias NKDraggingSource = NSDraggingSource
public typealias NKDragOperation = NSDragOperation

// MARK: - Menu
public typealias NKMenu = NSMenu
public typealias NKMenuItem = NSMenuItem

// MARK: - Toolbar
public typealias NKToolbar = NSToolbar
public typealias NKToolbarItem = NSToolbarItem

// MARK: - Layout & Geometry
public typealias NKEdgeInsets = NSEdgeInsets
public typealias NKRect = NSRect
public typealias NKSize = NSSize
public typealias NKPoint = NSPoint
public typealias NKLayoutConstraint = NSLayoutConstraint

// MARK: - Pasteboard
public typealias NKPasteboard = NSPasteboard
public typealias NKPasteboardItem = NSPasteboardItem
public typealias NKDraggingItem = NSDraggingItem
public typealias NKDraggingContext = NSDraggingContext

// MARK: - Visual Effects
public typealias NKVisualEffectView = NSVisualEffectView

// MARK: - Animation
public typealias NKAnimationContext = NSAnimationContext

// MARK: - Appearance
public typealias NKAppearance = NSAppearance

// MARK: - Tracking
public typealias NKTrackingArea = NSTrackingArea

// MARK: - Clip View
public typealias NKClipView = NSClipView

// MARK: - Protocols (as typealiases for consistency)
public typealias NKOutlineViewDataSource = NSOutlineViewDataSource
public typealias NKOutlineViewDelegate = NSOutlineViewDelegate
public typealias NKTableViewDataSource = NSTableViewDataSource
public typealias NKTableViewDelegate = NSTableViewDelegate
public typealias NKTextViewDelegate = NSTextViewDelegate
public typealias NKTextFieldDelegate = NSTextFieldDelegate
public typealias NKSearchFieldDelegate = NSSearchFieldDelegate

// MARK: - Attributed Strings
public typealias NKMutableAttributedString = NSMutableAttributedString
public typealias NKAttributedString = NSAttributedString

// MARK: - Other
public typealias NKCoder = NSCoder
public typealias NKUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier
public typealias NKRegularExpression = NSRegularExpression
public typealias NKRange = NSRange
public typealias NKUnderlineStyle = NSUnderlineStyle

// MARK: - Graphics Context
public func NKGraphicsGetCurrentContext() -> CGContext? {
    NSGraphicsContext.current?.cgContext
}

#elseif canImport(UIKit)

// MARK: - View Types
public typealias NKView = UIView
public typealias NKViewController = UIViewController
public typealias NKWindow = UIWindow
public typealias NKWindowScene = UIWindowScene
public typealias NKApplication = UIApplication
public typealias NKScreen = UIScreen
public typealias NKResponder = UIResponder

// MARK: - Controls
public typealias NKControl = UIControl
public typealias NKButton = UIButton
public typealias NKLabel = UILabel
public typealias NKTextField = UITextField
public typealias NKTextView = UITextView
public typealias NKSearchBar = UISearchBar
public typealias NKSearchController = UISearchController
public typealias NKSegmentedControl = UISegmentedControl
public typealias NKSwitch = UISwitch
public typealias NKSlider = UISlider
public typealias NKColorWell = UIColorWell

// MARK: - Container Views
public typealias NKScrollView = UIScrollView
public typealias NKStackView = UIStackView
public typealias NKSplitViewController = UISplitViewController
public typealias NKTabBarController = UITabBarController

// MARK: - Table/Collection Views
public typealias NKTableView = UITableView
public typealias NKTableViewCell = UITableViewCell
public typealias NKCollectionView = UICollectionView
public typealias NKCollectionViewCell = UICollectionViewCell

// MARK: - Images & Graphics
public typealias NKImage = UIImage
public typealias NKImageView = UIImageView
public typealias NKColor = UIColor
public typealias NKFont = UIFont
public typealias NKBezierPath = UIBezierPath
public typealias NKGraphicsContext = UIGraphicsImageRenderer

// MARK: - Alerts
public typealias NKAlertController = UIAlertController

// MARK: - Events & Gestures
public typealias NKEvent = UIEvent
public typealias NKGestureRecognizer = UIGestureRecognizer
public typealias NKPanGestureRecognizer = UIPanGestureRecognizer
public typealias NKTapGestureRecognizer = UITapGestureRecognizer
public typealias NKLongPressGestureRecognizer = UILongPressGestureRecognizer
public typealias NKPinchGestureRecognizer = UIPinchGestureRecognizer

// MARK: - Drag & Drop
public typealias NKDragInteraction = UIDragInteraction
public typealias NKDropInteraction = UIDropInteraction
public typealias NKDropInteractionDelegate = UIDropInteractionDelegate
public typealias NKDropSession = UIDropSession
public typealias NKDropProposal = UIDropProposal

// MARK: - Menu
public typealias NKMenu = UIMenu
public typealias NKAction = UIAction
public typealias NKContextMenuInteraction = UIContextMenuInteraction

// MARK: - Navigation & Toolbar
public typealias NKNavigationController = UINavigationController
public typealias NKBarButtonItem = UIBarButtonItem

// MARK: - Layout & Geometry
public typealias NKEdgeInsets = UIEdgeInsets
public typealias NKLayoutConstraint = NSLayoutConstraint

// MARK: - Pasteboard
public typealias NKPasteboard = UIPasteboard

// MARK: - Visual Effects
public typealias NKVisualEffectView = UIVisualEffectView
public typealias NKBlurEffect = UIBlurEffect

// MARK: - Alert Actions
public typealias NKAlertAction = UIAlertAction

// MARK: - Tab Bar
public typealias NKTabBarItem = UITabBarItem

// MARK: - Protocols
public typealias NKTableViewDataSource = UITableViewDataSource
public typealias NKTableViewDelegate = UITableViewDelegate
public typealias NKTextViewDelegate = UITextViewDelegate
public typealias NKTextFieldDelegate = UITextFieldDelegate
public typealias NKSearchBarDelegate = UISearchBarDelegate
public typealias NKSearchResultsUpdating = UISearchResultsUpdating
public typealias NKDocumentPickerDelegate = UIDocumentPickerDelegate

// MARK: - Document Picker
public typealias NKDocumentPickerViewController = UIDocumentPickerViewController

// MARK: - Attributed Strings
public typealias NKMutableAttributedString = NSMutableAttributedString
public typealias NKAttributedString = NSAttributedString

// MARK: - Other (Foundation types shared across platforms)
public typealias NKCoder = NSCoder
public typealias NKRegularExpression = NSRegularExpression
public typealias NKRange = NSRange
public typealias NKUnderlineStyle = NSUnderlineStyle

// MARK: - Graphics Context
public func NKGraphicsGetCurrentContext() -> CGContext? {
    UIGraphicsGetCurrentContext()
}

#endif
