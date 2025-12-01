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

// IPv6Standard.swift
// swift-ipv6-standard
//
// IPv6 Address Standard Package
//
// This package composes foundational IPv6 specifications into a unified standard.
//
// Current composition:
// - RFC 4291: IPv6 Addressing Architecture (structure and semantics)
// - RFC 5952: Canonical Text Representation (lowercase, :: compression)
// - RFC 4007: Scoped Address Architecture (zone identifiers)
//
// Future extensions:
// - RFC 4193: Unique Local IPv6 Unicast Addresses (ULA)
// - RFC 6164: IPv6 Addressing for Point-to-Point Links
// - RFC 8200: IPv6 Specification (full protocol)

@_exported import RFC_4007
@_exported import RFC_4291
@_exported import RFC_5952

/// IPv6 Standard namespace
///
/// This namespace provides a unified interface to IPv6 addressing standards.
/// It composes multiple RFCs into a cohesive whole.
///
/// ## Current Implementation
///
/// - **RFC 4291**: Core IPv6 address structure (128-bit, 8 segments)
/// - **RFC 5952**: Canonical text representation (lowercase, `::` compression)
/// - **RFC 4007**: Scoped addresses with zone identifiers (e.g., `fe80::1%eth0`)
///
/// ## Usage
///
/// ```swift
/// import IPv6_Standard
///
/// // Create addresses
/// let loopback = IPv6.Address.loopback
/// let linkLocal = IPv6.Address(0xfe80, 0, 0, 0, 0, 0, 0, 1)
///
/// // String representation (RFC 5952)
/// print(String(loopback))  // "::1"
/// print(String(linkLocal))  // "fe80::1"
///
/// // Scoped addresses (RFC 4007)
/// let scoped = IPv6.ScopedAddress(address: linkLocal, zone: "eth0")
/// print(String(scoped))  // "fe80::1%eth0"
/// ```
public enum IPv6Standard {}

/// Convenience typealias for IPv6
///
/// Allows writing `IPv6.Address` instead of `RFC_4291.IPv6.Address`
public typealias IPv6 = RFC_4291.IPv6
