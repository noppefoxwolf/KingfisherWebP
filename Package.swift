// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KingfisherWebP",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "KingfisherWebP",
            targets: ["KingfisherWebP"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.3.0"),
    ],
    targets: [
        .target(
            name: "KingfisherWebP",
            dependencies: ["Kingfisher"],
            path: "Sources"
        ),
        .testTarget(
            name: "KingfisherWebPTests",
            dependencies: ["KingfisherWebP"]
        )
    ]
)
