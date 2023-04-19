// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Iconoir",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Iconoir",
            targets: ["Iconoir"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Iconoir",
            dependencies: [],
            path: "Sources/Iconoir"),
        .testTarget(
            name: "IconoirTests",
            dependencies: ["Iconoir"],
            path: "Tests/IconoirTests"),
    ]
)
