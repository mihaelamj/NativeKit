// NativeKit.Colors.swift
// NativeKit
//
// Native platform color constants using AppKit/UIKit.

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

extension NativeKit {
    /// Native platform color accessors.
    ///
    /// Use these when you need the actual NSColor/UIColor rather than SwiftUI Color.
    /// Access via `NativeKit.Colors.label`, `NativeKit.Colors.background`, etc.
    public enum Colors {
        // MARK: - Backgrounds

        /// Background color for control elements.
        public static var controlBackground: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .controlBackgroundColor
            #else
            .systemBackground
            #endif
        }

        /// Background color for text areas.
        public static var textBackground: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .textBackgroundColor
            #else
            .secondarySystemBackground
            #endif
        }

        /// Primary window/view background.
        public static var background: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .windowBackgroundColor
            #else
            .systemBackground
            #endif
        }

        /// Secondary background.
        public static var secondaryBackground: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .underPageBackgroundColor
            #else
            .secondarySystemBackground
            #endif
        }

        /// Tertiary background.
        public static var tertiaryBackground: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .controlBackgroundColor
            #else
            .tertiarySystemBackground
            #endif
        }

        // MARK: - Separators

        /// Separator line color.
        public static var separator: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .separatorColor
            #else
            .separator
            #endif
        }

        // MARK: - Labels

        /// Primary label color.
        public static var label: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .labelColor
            #else
            .label
            #endif
        }

        /// Secondary label color.
        public static var secondaryLabel: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .secondaryLabelColor
            #else
            .secondaryLabel
            #endif
        }

        /// Tertiary label color.
        public static var tertiaryLabel: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .tertiaryLabelColor
            #else
            .tertiaryLabel
            #endif
        }

        // MARK: - Fill

        /// Primary fill color.
        public static var fill: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .systemFill
            #else
            .systemFill
            #endif
        }

        /// Secondary fill color.
        public static var secondaryFill: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .secondarySystemFill
            #else
            .secondarySystemFill
            #endif
        }

        /// Tertiary fill color.
        public static var tertiaryFill: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .tertiarySystemFill
            #else
            .tertiarySystemFill
            #endif
        }

        /// Quaternary fill color.
        public static var quaternaryFill: NKColor {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            .quaternarySystemFill
            #else
            .quaternarySystemFill
            #endif
        }
    }
}
