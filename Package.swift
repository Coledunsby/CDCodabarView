// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "CDCodabarView",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "CDCodabarView", targets: ["CDCodabarView"])
    ],
    targets: [
        .target(name: "CDCodabarView"),
        .testTarget(name: "CDCodabarViewTests", dependencies: ["CDCodabarView"])
    ]
)
