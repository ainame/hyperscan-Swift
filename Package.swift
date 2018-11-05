// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Hyperscan",
    products: [
      .library(name: "Hyperscan", targets: ["Hyperscan"]),
      .executable(name: "Example", targets: ["Example"]),
    ],
    dependencies: [
      .package(path: "./Modules/CHyperscan"),
    ],
    targets: [
      //.systemLibrary(name: "CHyperscan", path: "./Modules/CHyperscan"),
      .target(name: "Hyperscan", dependencies: ["CHyperscan"]),
      .target(name: "Example", dependencies: ["Hyperscan"]),
      .testTarget(name: "HyperscanTests", dependencies: ["Hyperscan"]),
    ]
)
