// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LineSimplifier",
    products: [
        .library(
            name: "LineSimplifier",
            targets: [
                "LineSimplifier"
            ]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "LineSimplifier"
        ),
        .testTarget(
            name: "LineSimplifierTests",
            dependencies: [
                "LineSimplifier"
            ],
            resources: [
                .copy("MyResources")
            ]
        ),
    ]
)
