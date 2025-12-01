// NativeKit.Fonts.swift
// NativeKit
//
// Native platform font helpers for AppKit/UIKit.

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

extension NativeKit {
    /// Native platform font utilities.
    ///
    /// Access via `NativeKit.Fonts.monospaced(...)`, `NativeKit.Fonts.monospacedPreferred(...)`.
    public enum Fonts {
        /// Monospaced system font with explicit size.
        public static func monospaced(ofSize size: CGFloat, weight: NKFont.Weight = .regular) -> NKFont {
            .monospacedSystemFont(ofSize: size, weight: weight)
        }

        /// Preferred monospaced font for the given text style, respecting Dynamic Type.
        public static func monospacedPreferred(forTextStyle style: NKFont.TextStyle, weight: NKFont.Weight = .regular) -> NKFont {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let preferred = NSFont.preferredFont(forTextStyle: style)
            #else
            let preferred = UIFont.preferredFont(forTextStyle: style)
            #endif
            return monospaced(ofSize: preferred.pointSize, weight: weight)
        }
    }
}
