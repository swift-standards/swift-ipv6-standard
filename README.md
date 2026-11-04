# swift-ipv6-standard

Use this package when you work with IPv6 addresses, including their text form and zones for scoped addresses, and want one import that writes `IPv6` rather than naming each RFC. Start from `IPv6.Address`, and use `RFC_4007.IPv6.ScopedAddress` when a link-local address needs its zone. `IPv6` is the same type as `RFC_4291.IPv6`, so depend on swift-rfc-4291, swift-rfc-5952 or swift-rfc-4007 directly if you need only one of them. For IPv4 use swift-ipv4-standard.
