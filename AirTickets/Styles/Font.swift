import SwiftUI

public extension Font {
    /// Namespace to prevent naming collisions with static accessors on
    /// SwiftUI's Font.
    ///
    /// Xcode's autocomplete allows for easy discovery of design system fonts.
    /// At any call site that requires a font, type `Font.DesignSystem.<esc>`
    struct DesignSystem {
        public static let title1 = Font.system(size: 22, weight: .semibold, design: .default)
        public static let title2 = Font.system(size: 20, weight: .semibold, design: .default)
        public static let title3 = Font.system(size: 16, weight: .semibold, design: .default)
        public static let text1 = Font.system(size: 16, weight: .regular, design: .default)
        public static let buttonText1 = Font.system(size: 16, weight: .semibold, design: .default)
        public static let title4 = Font.system(size: 14, weight: .medium, design: .default)
        public static let text2 = Font.system(size: 14, weight: .regular, design: .default)
        public static let tabText = Font.system(size: 10, weight: .regular, design: .default)
    }
}
