//
//  NativeKit.VisualEffects.swift
//  NativeKit
//
//  Platform-specific visual effect materials and blur styles.
//

#if os(macOS)

extension NativeKit {
    /// Semantic visual effect materials with availability handling.
    ///
    /// Access via `NativeKit.VisualEffectMaterial.sidebar`, etc.
    public enum VisualEffectMaterial {
        case sidebar
        case headerView
        case contentBackground
        case menu
        case popover
        case titlebar

        /// Returns the NSVisualEffectView.Material with availability handling.
        @available(macOS 10.10, *)
        public var nsMaterial: NSVisualEffectView.Material {
            if #available(macOS 10.14, *) {
                switch self {
                case .sidebar: return .sidebar
                case .headerView: return .headerView
                case .contentBackground: return .contentBackground
                case .menu: return .menu
                case .popover: return .popover
                case .titlebar: return .titlebar
                }
            } else {
                // Fallback for older macOS versions
                switch self {
                case .sidebar, .contentBackground: return .light
                case .headerView, .titlebar: return .titlebar
                case .menu, .popover: return .menu
                }
            }
        }
    }
}
#endif

#if os(iOS)

extension NativeKit {
    /// Semantic blur effect styles with availability handling.
    ///
    /// Access via `NativeKit.BlurEffectStyle.systemMaterial`, etc.
    public enum BlurEffectStyle {
        case systemMaterial
        case systemThinMaterial
        case systemUltraThinMaterial
        case systemThickMaterial
        case systemChromeMaterial
        case regular
        case prominent

        /// Returns the UIBlurEffect.Style with availability handling.
        public var uiStyle: UIBlurEffect.Style {
            if #available(iOS 13.0, *) {
                switch self {
                case .systemMaterial: return .systemMaterial
                case .systemThinMaterial: return .systemThinMaterial
                case .systemUltraThinMaterial: return .systemUltraThinMaterial
                case .systemThickMaterial: return .systemThickMaterial
                case .systemChromeMaterial: return .systemChromeMaterial
                case .regular: return .regular
                case .prominent: return .prominent
                }
            } else {
                // Fallback for older iOS versions
                switch self {
                case .regular, .systemMaterial, .systemThinMaterial, .systemUltraThinMaterial, .systemThickMaterial:
                    return .regular
                case .prominent, .systemChromeMaterial:
                    return .prominent
                }
            }
        }
    }
}
#endif
