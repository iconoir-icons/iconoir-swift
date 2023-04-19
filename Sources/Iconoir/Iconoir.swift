// Created by: Matthew Kaulfers
// License: MIT
// Version: 1.0.0
#if canImport(UIKit)
import UIKit

public extension Iconoir {
    var asUIImage: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.module, compatibleWith: nil)
    }
}
#endif

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13, macOS 10.15, *)
public extension Iconoir {
    var asImage: Image {
        return Image(self.rawValue, bundle: Bundle.module)
            .renderingMode(.template)
    }
}
#endif

