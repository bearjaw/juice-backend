// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "juice-backend",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
        .package(url: "https://github.com/bearjaw/MusicCore.git", from: "1.1.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "4.0.0"),
        .package(url: "https://github.com/johnsundell/Plot.git", from: "0.7.0"),
        .package(url: "https://github.com/vapor/leaf", from: "4.0.0"),
        .package(url: "https://github.com/vapor/leaf-kit", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "JWT", package: "jwt"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "MusicCore", package: "MusicCore"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Leaf", package: "Leaf"),
                "Plot"
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .target(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
