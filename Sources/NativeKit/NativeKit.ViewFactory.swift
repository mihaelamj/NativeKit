// NativeKit - Cross-platform view factory

import Foundation

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
#elseif canImport(UIKit)
#endif

// MARK: - View Factory

extension NativeKit {
    @MainActor
    public struct ViewFactory {
        private init() {}

        // MARK: - Labels

        public static func label(
            _ text: String,
            size: CGFloat = 13,
            weight: NKFont.Weight = .regular,
            color: NKColor = .nkLabel,
            maxLines: Int = 1,
            truncate: Bool = true
        ) -> NKLabel {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let label = NSTextField(labelWithString: text)
            label.font = .systemFont(ofSize: size, weight: weight)
            label.textColor = color
            label.translatesAutoresizingMaskIntoConstraints = false
            label.maximumNumberOfLines = maxLines
            label.lineBreakMode = truncate ? .byTruncatingTail : .byWordWrapping
            label.cell?.truncatesLastVisibleLine = true
            return label
            #elseif canImport(UIKit)
            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: size, weight: weight)
            label.textColor = color
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = maxLines
            label.lineBreakMode = truncate ? .byTruncatingTail : .byWordWrapping
            return label
            #endif
        }

        public static func monospacedLabel(
            _ text: String,
            size: CGFloat = 12,
            weight: NKFont.Weight = .regular,
            color: NKColor = .nkLabel
        ) -> NKLabel {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let label = NSTextField(labelWithString: text)
            label.font = .monospacedSystemFont(ofSize: size, weight: weight)
            label.textColor = color
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
            #elseif canImport(UIKit)
            let label = UILabel()
            label.text = text
            label.font = .monospacedSystemFont(ofSize: size, weight: weight)
            label.textColor = color
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
            #endif
        }

        // MARK: - Buttons

        public static func button(
            title: String,
            action: Selector,
            target: AnyObject?
        ) -> NKButton {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let button = NSButton(title: title, target: target, action: action)
            button.bezelStyle = .rounded
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
            #elseif canImport(UIKit)
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            if let target = target {
                button.addTarget(target, action: action, for: .touchUpInside)
            }
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
            #endif
        }

        public static func iconButton(
            systemName: String,
            action: Selector,
            target: AnyObject?,
            size: CGFloat = 16
        ) -> NKButton {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let button = NSButton()
            button.image = NSImage(systemSymbolName: systemName, accessibilityDescription: nil)
            button.symbolConfiguration = NSImage.SymbolConfiguration(pointSize: size, weight: .medium)
            button.bezelStyle = .recessed
            button.isBordered = false
            button.target = target
            button.action = action
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
            #elseif canImport(UIKit)
            let button = UIButton(type: .system)
            let config = UIImage.SymbolConfiguration(pointSize: size, weight: .medium)
            button.setImage(UIImage(systemName: systemName, withConfiguration: config), for: .normal)
            if let target = target {
                button.addTarget(target, action: action, for: .touchUpInside)
            }
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
            #endif
        }

        public static func pillButton(
            title: String,
            color: NKColor,
            action: Selector,
            target: AnyObject?
        ) -> NKButton {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let button = NSButton(title: title, target: target, action: action)
            button.bezelStyle = .rounded
            button.wantsLayer = true
            button.layer?.cornerRadius = 12
            button.layer?.backgroundColor = color.cgColor
            button.contentTintColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
            #elseif canImport(UIKit)
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.backgroundColor = color
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 12
            if let target = target {
                button.addTarget(target, action: action, for: .touchUpInside)
            }
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
            #endif
        }

        // MARK: - Separators

        public static func separator(vertical: Bool = false) -> NKView {
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let box = NSBox()
            box.boxType = .separator
            box.translatesAutoresizingMaskIntoConstraints = false
            return box
            #elseif canImport(UIKit)
            let view = UIView()
            view.backgroundColor = .separator
            view.translatesAutoresizingMaskIntoConstraints = false
            if vertical {
                view.widthAnchor.constraint(equalToConstant: 1).isActive = true
            } else {
                view.heightAnchor.constraint(equalToConstant: 1).isActive = true
            }
            return view
            #endif
        }

        // MARK: - Containers

        public static func card(
            cornerRadius: CGFloat = 12,
            backgroundColor: NKColor = .nkSecondaryBackground
        ) -> NKView {
            let view = NKView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.nkBackgroundColor = backgroundColor
            view.nkCornerRadius = cornerRadius
            return view
        }

        public static func scrollView() -> NKScrollView {
            let scrollView = NKScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            scrollView.hasVerticalScroller = true
            scrollView.hasHorizontalScroller = false
            scrollView.drawsBackground = false
            #elseif canImport(UIKit)
            scrollView.showsVerticalScrollIndicator = true
            scrollView.showsHorizontalScrollIndicator = false
            #endif
            return scrollView
        }

        public static func stackView(
            axis: StackAxis,
            spacing: CGFloat = 8,
            alignment: StackAlignment = .leading
        ) -> NKStackView {
            let stack = NKStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            stack.orientation = axis == .horizontal ? .horizontal : .vertical
            stack.spacing = spacing
            // AppKit alignment depends on stack orientation:
            // - Vertical stack: leading/centerX/trailing/width (horizontal alignment of children)
            // - Horizontal stack: top/centerY/bottom/height (vertical alignment of children)
            if axis == .vertical {
                switch alignment {
                case .leading: stack.alignment = .leading
                case .center: stack.alignment = .centerX
                case .trailing: stack.alignment = .trailing
                case .fill: stack.alignment = .width
                }
            } else {
                switch alignment {
                case .leading: stack.alignment = .top
                case .center: stack.alignment = .centerY
                case .trailing: stack.alignment = .bottom
                case .fill: stack.alignment = .height
                }
            }
            #elseif canImport(UIKit)
            stack.axis = axis == .horizontal ? .horizontal : .vertical
            stack.spacing = spacing
            switch alignment {
            case .leading: stack.alignment = .leading
            case .center: stack.alignment = .center
            case .trailing: stack.alignment = .trailing
            case .fill: stack.alignment = .fill
            }
            #endif
            return stack
        }

        // MARK: - Image Views

        public static func imageView(
            systemName: String,
            size: CGFloat = 24,
            color: NKColor = .nkLabel
        ) -> NKImageView {
            let imageView = NKImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            #if canImport(AppKit) && !targetEnvironment(macCatalyst)
            imageView.image = NSImage(systemSymbolName: systemName, accessibilityDescription: nil)
            imageView.symbolConfiguration = NSImage.SymbolConfiguration(pointSize: size, weight: .medium)
            imageView.contentTintColor = color
            #elseif canImport(UIKit)
            let config = UIImage.SymbolConfiguration(pointSize: size, weight: .medium)
            imageView.image = UIImage(systemName: systemName, withConfiguration: config)
            imageView.tintColor = color
            #endif
            return imageView
        }
    }

    // MARK: - Types

    public enum StackAxis {
        case horizontal
        case vertical
    }

    public enum StackAlignment {
        case leading
        case center
        case trailing
        case fill
    }
}

// MARK: - Backwards Compatibility

public typealias ViewFactory = NativeKit.ViewFactory
public typealias StackAxis = NativeKit.StackAxis
public typealias StackAlignment = NativeKit.StackAlignment
