import PackageDescription

let package = Package(
    name: "SwifterJSON",
    dependencies: [
        .Package(url: "https://github.com/Balancingrock/Ascii", "1.0.0"),
        .Package(url: "https://github.com/Balancingrock/BRUtils", "0.3.0")
    ]
)
