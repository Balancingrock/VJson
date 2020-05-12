// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "VJson",
    products: [
        .library(name: "VJson", targets: ["VJson"])
    ],
    dependencies: [
        .package(url: "https://github.com/Balancingrock/Ascii", from: "1.4.0"),
        .package(url: ".../BRUtils", from: "1.1.0")
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
