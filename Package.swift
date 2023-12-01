// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "AoCRunner", targets: ["AoCRunner"]),
        .library(name: "Helper", targets: ["Helper"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-algorithms.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .executableTarget(name: "AoCRunner",
                          dependencies: [.byName(name: "Days")] ),
        .target(name: "Helper"),
        .target(name: "Days",
                dependencies: [
                    .product(name: "Algorithms", package: "swift-algorithms"),
                    .product(name: "Collections", package: "swift-collections"),
                    .target(name: "Helper")
                ], resources: [.process("Inputs")]
               )
    ]
)
