// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LaTeXSwiftUI",
  platforms: [
    .iOS(.v15),
    .macOS(.v12)
  ],
  products: [
    .library(
      name: "LaTeXSwiftUI",
      targets: ["LaTeXSwiftUI"]),
  ],
  dependencies: [
     // DOWNSTREAM PATCH (noctext-cjk): point at our MathJaxSwift fork whose
     // JSExport flattening patch makes svgOptions.mtextFont actually reach
     // MathJax. Keeping upstream's URL here produces a SwiftPM identity
     // collision ("mathjaxswift" resolves to two locations) when the host
     // app also adds patr1ckzhu/MathJaxSwift directly — which it does, to
     // pin the exact commit it needs.
     .package(url: "https://github.com/patr1ckzhu/MathJaxSwift", revision: "94606d4338e87aa1631c821dad15e91f1cff1617"),
     .package(url: "https://github.com/swhitty/SwiftDraw", from: "0.20.1"),
     .package(url: "https://github.com/Kitura/swift-html-entities", from: "4.0.1")
  ],
  targets: [
    .target(
      name: "LaTeXSwiftUI",
      dependencies: [
        "MathJaxSwift",
        "SwiftDraw",
        .product(name: "HTMLEntities", package: "swift-html-entities")
      ]),
    .testTarget(
      name: "LaTeXSwiftUITests",
      dependencies: ["LaTeXSwiftUI"]),
  ]
)
