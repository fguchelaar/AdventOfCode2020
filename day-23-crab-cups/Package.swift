// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "day-23",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../AdventKit"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "Puzzle",
            dependencies: ["AdventKit"]
        ),
        .testTarget(
            name: "PuzzleTests",
            dependencies: ["Puzzle"]
        ),
    ]
)
