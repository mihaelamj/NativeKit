// KeyboardShortcuts.swift
// Centralized keyboard shortcut configuration for the application
// Modify shortcuts here to change them throughout the app

import Foundation

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

// MARK: - Keyboard Shortcuts Configuration

/// Centralized keyboard shortcuts configuration
/// All keyboard shortcuts used in the app should be defined here
public enum KeyboardShortcuts {

    // MARK: - Canvas Zoom

    /// Shortcuts for canvas zoom operations
    /// Uses Option+/- (like Final Cut Pro Timeline) to avoid conflict with text size shortcuts (Cmd+/-)
    /// Uses Shift+Z for reset/fit (like Final Cut Pro)
    public enum CanvasZoom {
        /// Modifier keys required for zoom in/out shortcuts
        public static let modifiers: NSEvent.ModifierFlags = [.option]

        /// Characters that trigger zoom in (= and +)
        public static let zoomInCharacters: Set<String> = ["=", "+"]

        /// Character that triggers zoom out (-)
        public static let zoomOutCharacter: String = "-"

        /// Reset/Fit uses Shift+Z (like Final Cut Pro)
        public static let resetModifiers: NSEvent.ModifierFlags = [.shift]
        public static let resetCharacter: String = "z"

        /// Check if event matches zoom in shortcut (Option + or Option =)
        public static func isZoomIn(_ event: NSEvent) -> Bool {
            guard hasRequiredModifiers(event) else { return false }
            guard let chars = event.charactersIgnoringModifiers else { return false }
            return zoomInCharacters.contains(chars)
        }

        /// Check if event matches zoom out shortcut (Option -)
        public static func isZoomOut(_ event: NSEvent) -> Bool {
            guard hasRequiredModifiers(event) else { return false }
            return event.charactersIgnoringModifiers == zoomOutCharacter
        }

        /// Check if event matches zoom reset shortcut (Shift+Z)
        public static func isReset(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.shift) else { return false }
            // Make sure Command is not pressed (to avoid conflict with Cmd+Shift+Z = Redo)
            guard !event.modifierFlags.contains(.command) else { return false }
            return event.charactersIgnoringModifiers?.lowercased() == resetCharacter
        }

        /// Check if event has the required modifier keys for zoom in/out
        public static func hasRequiredModifiers(_ event: NSEvent) -> Bool {
            return event.modifierFlags.contains(.option)
        }

        /// Human-readable description of zoom in shortcut
        public static var zoomInDescription: String { "⌥+" }

        /// Human-readable description of zoom out shortcut
        public static var zoomOutDescription: String { "⌥-" }

        /// Human-readable description of reset shortcut
        public static var resetDescription: String { "⇧Z" }
    }

    // MARK: - Node Operations

    /// Shortcuts for node operations on canvas
    public enum NodeOperations {
        /// Delete selected node(s)
        public static let deleteModifiers: NSEvent.ModifierFlags = []
        public static let deleteKeyCode: UInt16 = 51 // Backspace

        /// Check if event matches delete shortcut
        public static func isDelete(_ event: NSEvent) -> Bool {
            return event.keyCode == deleteKeyCode ||
                   event.charactersIgnoringModifiers == "\u{7F}" // Delete character
        }

        /// Select all nodes
        public static let selectAllModifiers: NSEvent.ModifierFlags = [.command]
        public static let selectAllCharacter: String = "a"

        /// Check if event matches select all shortcut
        public static func isSelectAll(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.command) else { return false }
            return event.charactersIgnoringModifiers == selectAllCharacter
        }

        /// Duplicate selected node(s)
        public static let duplicateModifiers: NSEvent.ModifierFlags = [.command]
        public static let duplicateCharacter: String = "d"

        /// Check if event matches duplicate shortcut
        public static func isDuplicate(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.command) else { return false }
            return event.charactersIgnoringModifiers == duplicateCharacter
        }

        /// Human-readable descriptions
        public static var deleteDescription: String { "⌫" }
        public static var selectAllDescription: String { "⌘A" }
        public static var duplicateDescription: String { "⌘D" }
    }

    // MARK: - File Operations

    /// Shortcuts for file operations
    public enum FileOperations {
        /// New document
        public static func isNew(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.command) else { return false }
            return event.charactersIgnoringModifiers == "n"
        }

        /// Open document
        public static func isOpen(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.command) else { return false }
            return event.charactersIgnoringModifiers == "o"
        }

        /// Save document
        public static func isSave(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.command) else { return false }
            return event.charactersIgnoringModifiers == "s"
        }

        /// Save As
        public static func isSaveAs(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.command) &&
                  event.modifierFlags.contains(.shift) else { return false }
            return event.charactersIgnoringModifiers == "s"
        }

        /// Human-readable descriptions
        public static var newDescription: String { "⌘N" }
        public static var openDescription: String { "⌘O" }
        public static var saveDescription: String { "⌘S" }
        public static var saveAsDescription: String { "⌘⇧S" }
    }

    // MARK: - Edit Operations

    /// Standard edit shortcuts (usually handled by system, but defined for reference)
    public enum EditOperations {
        /// Undo
        public static func isUndo(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.command) else { return false }
            return event.charactersIgnoringModifiers == "z"
        }

        /// Redo
        public static func isRedo(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.command) &&
                  event.modifierFlags.contains(.shift) else { return false }
            return event.charactersIgnoringModifiers == "z"
        }

        /// Copy
        public static func isCopy(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.command) else { return false }
            return event.charactersIgnoringModifiers == "c"
        }

        /// Cut
        public static func isCut(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.command) else { return false }
            return event.charactersIgnoringModifiers == "x"
        }

        /// Paste
        public static func isPaste(_ event: NSEvent) -> Bool {
            guard event.modifierFlags.contains(.command) else { return false }
            return event.charactersIgnoringModifiers == "v"
        }

        /// Human-readable descriptions
        public static var undoDescription: String { "⌘Z" }
        public static var redoDescription: String { "⌘⇧Z" }
        public static var copyDescription: String { "⌘C" }
        public static var cutDescription: String { "⌘X" }
        public static var pasteDescription: String { "⌘V" }
    }
}

#elseif canImport(UIKit)

// MARK: - UIKit Keyboard Shortcuts (for hardware keyboard on iPad)

/// Centralized keyboard shortcuts configuration for UIKit
public enum KeyboardShortcuts {

    // MARK: - Canvas Zoom

    public enum CanvasZoom {
        /// Modifier keys required for zoom in/out shortcuts
        /// Uses Option (like Final Cut Pro Timeline) to avoid conflict with text size shortcuts
        public static let modifiers: UIKeyModifierFlags = [.alternate]

        /// Characters that trigger zoom in
        public static let zoomInCharacters: Set<String> = ["=", "+"]

        /// Character that triggers zoom out
        public static let zoomOutCharacter: String = "-"

        /// Reset/Fit uses Shift+Z (like Final Cut Pro)
        public static let resetModifiers: UIKeyModifierFlags = [.shift]
        public static let resetCharacter: String = "z"

        /// Human-readable descriptions
        public static var zoomInDescription: String { "⌥+" }
        public static var zoomOutDescription: String { "⌥-" }
        public static var resetDescription: String { "⇧Z" }
    }

    // MARK: - Node Operations

    public enum NodeOperations {
        public static var deleteDescription: String { "⌫" }
        public static var selectAllDescription: String { "⌘A" }
        public static var duplicateDescription: String { "⌘D" }
    }

    // MARK: - File Operations

    public enum FileOperations {
        public static var newDescription: String { "⌘N" }
        public static var openDescription: String { "⌘O" }
        public static var saveDescription: String { "⌘S" }
        public static var saveAsDescription: String { "⌘⇧S" }
    }

    // MARK: - Edit Operations

    public enum EditOperations {
        public static var undoDescription: String { "⌘Z" }
        public static var redoDescription: String { "⌘⇧Z" }
        public static var copyDescription: String { "⌘C" }
        public static var cutDescription: String { "⌘X" }
        public static var pasteDescription: String { "⌘V" }
    }
}

#endif
