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
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11)
    ],
    products: [
        .library(name: .ipv6Standard, targets: [.ipv6Standard]),
    ],
    dependencies: [
        .package(path: "../swift-rfc-4291"),
        .package(path: "../swift-rfc-5952"),
        .package(path: "../swift-rfc-4007"),
    ],
    targets: [
        .target(
            name: .ipv6Standard,
            dependencies: [.rfc4291, .rfc5952, .rfc4007]
        ),
        .testTarget(
            name: .ipv6Standard.tests,
            dependencies: [.ipv6Standard]
        ),
    ],
    swiftLanguageModes: [.v6]
)
