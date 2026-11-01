//  FindMyEventKeyTests
//  A FindMy position is rate-limited per device, keyed by its `handle`.
//
//  The bus coalesces per key. With no key every device shared one bucket, so a burst of N
//  positions reached clients as two; the reference emits every item of a batch
//  (`PrivateApiFindMyEventHandler.ts`). `EventBusTests` covers the bus; this pins the key
//  the service hands it.
//
//  NO REAL ADDRESSES; see CONTRIBUTING.md.

import BBEvents
import BBPrivateAPIContract
import Testing

@testable import BlueBubblesServerCore

@Suite("FindMy event keys")
struct FindMyEventKeyTests {

  @Test("A FindMy position is keyed by its device's handle")
  func keyedByHandle() throws {
    let mapped = try #require(
      PrivateAPIGatedService.serverEvent(
        for: .findMyLocationUpdated(payload: ["handle": "someone@example.com"])))
    #expect(mapped.0.name == .newFindMyLocation)
    #expect(mapped.1 == "someone@example.com")
  }
}
