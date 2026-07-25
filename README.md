# IPv6 Standard

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

A unified `IPv6` standard for Swift — composes RFC 4291 addressing, RFC 5952 text representation, and RFC 4007 scoped-address definitions into a single namespace, with no Foundation dependency.

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-standards/swift-ipv6-standard.git", branch: "main")
]
```

Add the product to your target:

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "IPv6 Standard", package: "swift-ipv6-standard")
    ]
)
```

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
