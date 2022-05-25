// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "juice-backend",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor", from: "4.54.4"),
        .package(url: "https://github.com/bearjaw/MusicCore", from: "1.1.0"),
        .package(url: "https://github.com/vapor/jwt", from: "4.2.0"),
        .package(url: "https://github.com/binarybirds/swift-html", from: "1.2.0"),
        .package(url: "https://github.com/vapor/fluent", from: "4.4.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver", from: "4.1.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "JWT", package: "jwt"),
                .product(name: "MusicCore", package: "MusicCore"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "SwiftHtml", package: "swift-html"),
                .product(name: "SwiftSvg", package: "swift-html"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
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
