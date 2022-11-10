// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "maple-diffusion",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "maple-diffusion",
            targets: ["maple-diffusion"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/phimage/XcodeProjKit.git", from: "3.0.3")
    ],
    targets: [
        .executableTarget(
            name: "maple-diffusion",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "XcodeProjKit"],
            path: "Sources/main"
        )
    ]
)
