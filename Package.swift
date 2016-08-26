import PackageDescription

let package = Package(
    name: "SwiftTrend",
    dependencies: [
        .Package(url: "https://github.com/vapor/tls", majorVersion: 0, minor: 6),
        .Package(url: "https://github.com/vapor/vapor", majorVersion: 0, minor: 16)
    ],
    exclude: [
        "Config",
        "Tests",
    ]
)

