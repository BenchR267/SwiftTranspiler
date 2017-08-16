// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftTranspiler",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftTranspiler",
            targets: ["SwiftTranspiler"]),
    ],
    dependencies: [
        .package(url: "https://github.com/BenchR267/ParserCombinator", .branch("develop"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftTranspiler",
            dependencies: ["ParserCombinator"]),
        .testTarget(
            name: "SwiftTranspilerTests",
            dependencies: ["SwiftTranspiler"]),
    ]
)
