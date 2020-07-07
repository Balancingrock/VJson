// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "VJson",
    platforms: [.macOS(.10_12), .iOS(8)],
    products: [
        .library(name: "VJson", targets: ["VJson"])
    ],
    dependencies: [
        .package(url: "https://github.com/Balancingrock/Ascii", from: "1.5.0"),
        .package(url: "https://github.com/Balancingrock/BRUtils", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "VJson",
            dependencies: ["Ascii", "BRUtils"]
        ),
        .testTarget(
            name: "VJsonTests",
            dependencies: ["VJson"]
        )
    ],
    swiftLanguageVersions: [.v4, .v4_2, .v5]
)
