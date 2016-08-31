import PackageDescription

let package = Package(
    name: "SwiftTrend",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 17)
    ],
    exclude: [
        "Config",
        "Resources",
        "Tests",
    ]
)

