# Iconoir-swift

![Version](https://img.shields.io/badge/version-6.11.0-blue) ![License](https://img.shields.io/badge/license-MIT-green)

`Iconoir-swift` is a Swift package that extends the usage of [Iconoir](https://iconoir.com) icons for your iOS, macOS, and SwiftUI projects. It provides over 1000+ unique SVG icons designed on a 24x24 pixels grid, allowing you to easily use them in your app projects.

## Features

- Easily use Iconoir icons as `UIImage` and `Image` objects in your UIKit and SwiftUI projects
- Access to all 1000+ icons from the Iconoir library
- Easy integration with your existing iOS or macOS projects
- MIT licensed, open-source, and free to use

## Requirements

- iOS 13+
- macOS 10.15+
- Swift 5+

## Installation

To add `Iconoir-swift` to your Xcode project, follow these steps:

1. In Xcode, open your project and navigate to *File* > *Swift Packages* > *Add Package Dependency...*
2. Enter the repository URL: `https://github.com/iconoir-icons/iconoir-swift.git`
3. Choose the branch or version you want to add, and click *Next*.
4. Select the target where you want to use the package, then click *Finish*.

## Usage

### UIKit

```swift
import UIKit
import Iconoir_swift

let imageView = UIImageView(image: Iconoir.bell.asUIImage)
```

### SwiftUI

```swift
import SwiftUI
import Iconoir_swift

struct ContentView: View {
    var body: some View {
        Iconoir.bell.asImage
            .foregroundColor(.blue)
            .font(.system(size: 24))
    }
}
```
### Notes
Since Iconoir `V7.0.0`, we have introduced two styles of icons: `regular` and `solid`. To maintain consistency with previous rules, icons in the regular style continue to use the old naming convention. For example, prior to `v7.0.0`, you would use `Iconoir.plus`, and you can still do so now. On the other hand, for icons in the `solid style`, we will indicate this in the naming convention. For instance, you would use `Iconoir.plusSolid`. If an icon supports both styles, it will have two distinct names, as mentioned above: `plus` and `plusSolid`.


## Original Iconoir Project
Iconoir-swift is built on top of the original [Iconoir](https://iconoir.com/) project. You can access the full library of icons, as well as additional packages and usage instructions, at the [Iconoir GitHub repository](https://github.com/iconoir-icons/iconoir#readme).

## License
Iconoir-swift is released under the [MIT License](https://opensource.org/license/mit/).
