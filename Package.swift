// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftlyCache",
    products: [
        .library(
            name: "SwiftlyCache",
            targets: ["SwiftlyCache"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftlyCache"),
        .testTarget(
            name: "SwiftlyCacheTests",
            dependencies: ["SwiftlyCache"]
        ),
    ]
)
