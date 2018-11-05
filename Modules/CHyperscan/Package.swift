// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CHyperscan",
    pkgConfig: "libhs",
    providers: [
      .brew(["hyperscan"]),
    ],
    products: [
      .library(name: "CHyperscan", targets: ["CHyperscan"]),
    ],
    targets: [
      .systemLibrary(name: "CHyperscan"),
    ]
)
