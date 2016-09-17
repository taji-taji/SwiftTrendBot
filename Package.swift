import PackageDescription

let package = Package(
    name: "SwiftTrend",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 0)
    ],
    exclude: [
        "Config",
        "Resources",
        "Tests",
    ]
)
