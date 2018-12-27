// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "VJson",
    products: [
        .library(name: "VJson", targets: ["VJson"])
    ],
    dependencies: [
        .package(url: "https://github.com/Balancingrock/Ascii", from: "1.3.1"),
        .package(url: "https://github.com/Balancingrock/BRUtils", from: "0.12.0")
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
    ]
)
