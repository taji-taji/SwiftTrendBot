import PackageDescription

let package = Package(
    name: "SwiftTrend",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 18)
    ],
    exclude: [
        "Config",
        "Resources",
        "Tests",
    ]
)
