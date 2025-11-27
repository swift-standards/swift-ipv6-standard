// ===----------------------------------------------------------------------===//
//
// Copyright (c) 2025 Coen ten Thije Boonkkamp
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of project contributors
//
// SPDX-License-Identifier: Apache-2.0
//
// ===----------------------------------------------------------------------===//

import Testing
@testable import IPv6_Standard

@Suite("IPv6 Standard: Integration Tests")
struct IPv6StandardTests {

    // MARK: - Basic Integration

    @Test("Can access RFC 4291 types")
    func rfc4291Integration() throws {
        let address = IPv6.Address(0x2001, 0x0db8, 0, 0, 0, 0, 0, 1)
        #expect(address.segments.0 == 0x2001)
        #expect(address.segments.1 == 0x0db8)
    }

    @Test("Can access RFC 5952 canonical representation")
    func rfc5952Integration() throws {
        let address = IPv6.Address(0x2001, 0x0db8, 0, 0, 0, 0, 0, 1)
        let text = String(address)
        #expect(text == "2001:db8::1")
    }

    @Test("Can access RFC 4007 scoped addresses")
    func rfc4007Integration() throws {
        let linkLocal = IPv6.Address(0xfe80, 0, 0, 0, 0, 0, 0, 1)
        let scoped = RFC_4007.IPv6.ScopedAddress(address: linkLocal, zone: "eth0")

        #expect(String(scoped) == "fe80::1%eth0")
        #expect(scoped.requiresZone == true)
    }

    // MARK: - Well-Known Addresses

    @Test("Loopback address canonical form")
    func loopbackCanonical() throws {
        let loopback = IPv6.Address.loopback
        #expect(String(loopback) == "::1")
    }

    @Test("Unspecified address canonical form")
    func unspecifiedCanonical() throws {
        let unspecified = IPv6.Address.unspecified
        #expect(String(unspecified) == "::")
    }

    // MARK: - Type Aliases

    @Test("IPv6 typealias works")
    func typeAlias() throws {
        // Should be able to use IPv6 instead of RFC_4291.IPv6
        let address: IPv6.Address = .loopback
        #expect(address == RFC_4291.IPv6.Address.loopback)
    }

    // MARK: - Address Properties

    @Test("Address type detection")
    func addressTypes() throws {
        let loopback = IPv6.Address.loopback
        let linkLocal = IPv6.Address(0xfe80, 0, 0, 0, 0, 0, 0, 1)
        let multicast = IPv6.Address(0xff02, 0, 0, 0, 0, 0, 0, 1)
        let global = IPv6.Address(0x2001, 0x0db8, 0, 0, 0, 0, 0, 1)

        #expect(loopback.isLoopback == true)
        #expect(linkLocal.isLinkLocal == true)
        #expect(multicast.isMulticast == true)
        #expect(global.isGlobalUnicast == true)
    }

    // MARK: - Full Round-Trip

    @Test("Full IPv6 workflow")
    func fullWorkflow() throws {
        // Create address (RFC 4291)
        let address = IPv6.Address(0xfe80, 0, 0, 0, 0x0200, 0x5eff, 0xfe00, 0x0001)

        // Check properties (RFC 4291)
        #expect(address.isLinkLocal == true)

        // Canonical text (RFC 5952)
        let canonical = String(address)
        #expect(canonical == "fe80::200:5eff:fe00:1")

        // Scoped address (RFC 4007)
        let scoped = RFC_4007.IPv6.ScopedAddress(address: address, zone: "eth0")
        #expect(scoped.requiresZone == true)
        #expect(scoped.isProperlyScoped == true)
        #expect(String(scoped) == "fe80::200:5eff:fe00:1%eth0")
    }
}
