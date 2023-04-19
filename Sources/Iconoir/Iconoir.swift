// Created by: Matthew Kaulfers
// License: MIT
// Version: 6.6.0
#if canImport(UIKit)
import UIKit

public extension Iconoir {
    /// Returns a UIImage of the Iconoir icon.
    var asUIImage: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.module, compatibleWith: nil)
    }
}
#endif

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13, macOS 10.15, *)
public extension Iconoir {
    /// Returns a SwiftUI Image of the Iconoir icon.
    var asImage: Image {
        return Image(self.rawValue, bundle: Bundle.module)
            .renderingMode(.template)
    }
}
#endif
