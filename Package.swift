// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XCActivityLog",
    products: [
        .library(
            name: "XCActivityLog",
            targets: ["XCActivityLog"]),

        .library(
            name: "IDEActivityLog",
            targets: ["IDEActivityLog"]),

        .executable(
            name: "Application",
            targets: ["Application"]
        ),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "XCActivityLog",
            dependencies: []),
        .testTarget(
            name: "XCActivityLogTests",
            dependencies: ["XCActivityLog"]),
        
        .target(
            name: "IDEActivityLog",
            dependencies: ["XCActivityLog"]),
        .testTarget(
            name: "IDEActivityLogTests",
            dependencies: ["IDEActivityLog"]),

        .target(
            name: "Application",
            dependencies: ["XCActivityLog", "IDEActivityLog"]),

    ],
    cxxLanguageStandard: .cxx14
)
