import IPv6_Standard
import RFC_4007
import RFC_4291
import Testing

@Suite
struct `IPv6 Standard` {

    @Test
    func `IPv6 names the RFC 4291 address family`() throws {
        let address: IPv6.Address = .loopback
        #expect(address == RFC_4291.IPv6.Address.loopback)
        #expect(address.segments.7 == 1)
    }

    @Test
    func `RFC 4291 classifies an address by its prefix`() throws {
        let linkLocal = IPv6.Address(0xfe80, 0, 0, 0, 0, 0, 0, 1)
        let multicast = IPv6.Address(0xff02, 0, 0, 0, 0, 0, 0, 1)
        let global = IPv6.Address(0x2001, 0x0db8, 0, 0, 0, 0, 0, 1)

        #expect(IPv6.Address.loopback.is.loopback)
        #expect(IPv6.Address.unspecified.is.unspecified)
        #expect(linkLocal.is.linkLocal)
        #expect(multicast.is.multicast)
        #expect(global.is.globalUnicast)
    }

    @Test
    func `RFC 4007 scopes a link-local address with a zone`() throws {
        let linkLocal = IPv6.Address(0xfe80, 0, 0, 0, 0x0200, 0x5eff, 0xfe00, 0x0001)
        let scoped = RFC_4007.IPv6.ScopedAddress(address: linkLocal, zone: "eth0")

        #expect(scoped.zone == "eth0")
        #expect(scoped.requiresZone)
        #expect(scoped.isProperlyScoped)
    }

    @Test
    func `RFC 4007 leaves a global address unscoped`() throws {
        let global = IPv6.Address(0x2001, 0x0db8, 0, 0, 0, 0, 0, 1)
        let scoped = RFC_4007.IPv6.ScopedAddress(address: global)

        #expect(scoped.zone == nil)
        #expect(!scoped.requiresZone)
        #expect(scoped.isProperlyScoped)
    }
}
