// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Dope",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Dope",
            targets: ["Dope"]),
        .library(
            name: "Lisp",
            targets: ["Lisp"]),
        .executable(name: "repl", targets: ["repl"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-case-paths.git", from: "1.5.6"),
        .package(url: "https://github.com/pointfreeco/swift-parsing.git", from: "0.13.0"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Dope",
            dependencies: [
                .product(name: "CasePaths", package: "swift-case-paths")
            ]
        ),
        .target(
            name: "Lisp",
            dependencies: [
                "Dope",
                "ClojureMacros",
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax"),
                .product(name: "Parsing", package: "swift-parsing")
            ]
        ),
        .testTarget(
            name: "DopeTests",
            dependencies: ["Dope"]
        ),
        .testTarget(
            name: "LispTests",
            dependencies: ["Lisp"]
        ),
        
        .macro(
            name: "ClojureMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(name: "repl", dependencies: ["Lisp"]),
    ]
)
