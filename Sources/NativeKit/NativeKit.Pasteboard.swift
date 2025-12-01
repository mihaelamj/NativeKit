//
//  NativeKit.Pasteboard.swift
//  NativeKit
//
//  Platform-adaptive pasteboard operations for macOS and iOS.
//

import Foundation

#if os(macOS)
#else
#endif

extension NativeKit {
    /// Platform-adaptive pasteboard operations.
    ///
    /// Access via `NativeKit.Pasteboard.copy(...)`, `NativeKit.Pasteboard.paste()`.
    public enum Pasteboard {
        /// Copy text to the system pasteboard.
        ///
        /// - Parameter text: The text to copy.
        public static func copy(_ text: String) {
            #if os(macOS)
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(text, forType: .string)
            #else
            UIPasteboard.general.string = text
            #endif
        }

        /// Get text from the system pasteboard.
        ///
        /// - Returns: The text from the pasteboard, or nil if unavailable.
        public static func paste() -> String? {
            #if os(macOS)
            NSPasteboard.general.string(forType: .string)
            #else
            UIPasteboard.general.string
            #endif
        }
    }
}
