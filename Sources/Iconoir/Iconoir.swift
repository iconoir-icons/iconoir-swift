// Created by: Matthew Kaulfers
// License: MIT
// Version: 6.8.0
#if canImport(UIKit)
import UIKit

public extension Iconoir {
    /// Returns a UIImage of the Iconoir icon.
    var asUIImage: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.module, compatibleWith: nil)
    }
    
    /// Returns an image, from the Iconoir bundle, if there is a matching key, otheriwse nil.
    /// - Parameter string: key that matches iconoir icon.
    /// - Returns: UIKit UIImage
    static func uiImage(from string: String) -> UIImage? {
        return UIImage(named: string, in: Bundle.module, compatibleWith: nil)
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
    
    
    /// Returns an image, from the Iconoir bundle, if there is a matching key.
    /// - Parameter string: key that matches iconoir icon.
    /// - Returns: SwiftUI Image
    static func image(from string: String) -> Image {
        return Image(string, bundle: Bundle.module)
            .renderingMode(.template)
    }
}
#endif
