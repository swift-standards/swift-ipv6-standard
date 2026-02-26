// swift-tools-version: 6.2
import PackageDescription



extension String {
    static let ipv6Standard = "IPv6 Standard"
    var tests: Self { "\(self) Tests" }
}

extension Target.Dependency {
    static let ipv6Standard = Self.target(name: .ipv6Standard)
    static let rfc4291 = Self.product(name: "RFC 4291", package: "swift-rfc-4291")
    static let rfc5952 = Self.product(name: "RFC 5952", package: "swift-rfc-5952")
    static let rfc4007 = Self.product(name: "RFC 4007", package: "swift-rfc-4007")
}

let package = Package(
    name: "swift-ipv6-standard",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26)
    ],
    products: [
        .library(name: "IPv6 Standard", targets: ["IPv6 Standard"])
    ],
    dependencies: [
        .package(path: "../swift-rfc-4291"),
        .package(path: "../swift-rfc-5952"),
        .package(path: "../swift-rfc-4007")
    ],
    targets: [
        .target(
            name: "IPv6 Standard",
            dependencies: [.rfc4291, .rfc5952, .rfc4007]
        ),
        .testTarget(
            name: "IPv6 Standard Tests",
            dependencies: [
                "IPv6 Standard",
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
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableExperimentalFeature("SuppressedAssociatedTypesWithDefaults"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
