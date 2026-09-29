// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-ipv6-standard",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "IPv6 Standard",
            targets: ["IPv6 Standard"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-ietf/swift-rfc-4291.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-ietf/swift-rfc-5952.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-ietf/swift-rfc-4007.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "IPv6 Standard",
            dependencies: [
                .product(
                    name: "RFC 4291",
                    package: "swift-rfc-4291"
                ),
                .product(
                    name: "RFC 5952",
                    package: "swift-rfc-5952"
                ),
                .product(
                    name: "RFC 4007",
                    package: "swift-rfc-4007"
                )
            ]
        ),
        .testTarget(
            name: "IPv6 Standard Tests",
            dependencies: [
                "IPv6 Standard",
                .product(
                    name: "RFC 4291",
                    package: "swift-rfc-4291"
                ),
                .product(
                    name: "RFC 4007",
                    package: "swift-rfc-4007"
                ),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
