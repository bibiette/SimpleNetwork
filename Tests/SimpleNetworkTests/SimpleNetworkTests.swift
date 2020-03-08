import XCTest
@testable import SimpleNetwork

final class SimpleNetworkTests: XCTestCase {
     var mockService: MockService!
     
     override func setUp() {
         mockService = MockService()
     }
     
     func testWhenPingGoogle_ThenRequestSucceed() throws {
         let url = try XCTUnwrap(URL(string: "https://google.com"))
         let expectation = self.expectation(description: "Expectation")
         mockService
             .request(urlRequest: .make(endpoint: url))
             .done { _ in
                 expectation.fulfill()
         }
             .catch { error in
             XCTFail("Failed with error \(error)")
         }
         wait(for: [expectation], timeout: 30)
     }
     
     func testWhenRequestHasNotCompleted_ThenRequestIsNotReleased() throws {
         let url = try XCTUnwrap(URL(string: "https://google.com"))
         let expectation = self.expectation(description: "Expectation")
         weak var request = mockService.request(urlRequest: .make(endpoint: url))
         request?.result {  _ in
             expectation.fulfill()
         }
         XCTAssertNotNil(request)
         wait(for: [expectation], timeout: 30)
     }
     
     func testWhenRequestHasCompleted_ThenRequestIsReleased() throws {
         let url = try XCTUnwrap(URL(string: "https://google.com"))
         let expectation = self.expectation(description: "Expectation")
         weak var request = mockService.request(urlRequest: .make(endpoint: url))
         request?.result {  _ in
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 30)
         XCTAssertNil(request)
     }
     
     func testWhenAddQueryItems_ThenURLHasQueryItemsAdded() throws {
         var url = try XCTUnwrap(URL(string: "https://google.com"))
         url.add(queryItems: ["limit":"2"])
         XCTAssertEqual(url.absoluteString, "https://google.com?limit=2")
     }
     
     func testWhenAddEmptyQueryItems_ThenNoQueryItemsAreAdded() throws {
         var url = try XCTUnwrap(URL(string: "https://google.com"))
         url.add(queryItems: [:])
         XCTAssertEqual(url.absoluteString, "https://google.com")
     }

    static var allTests = [
        ("testWhenPingGoogle_ThenRequestSucceed", testWhenPingGoogle_ThenRequestSucceed),
        ("testWhenRequestHasNotCompleted_ThenRequestIsNotReleased", testWhenRequestHasNotCompleted_ThenRequestIsNotReleased),
        ("testWhenRequestHasCompleted_ThenRequestIsReleased", testWhenRequestHasCompleted_ThenRequestIsReleased),
        ("testWhenAddQueryItems_ThenURLHasQueryItemsAdded", testWhenAddQueryItems_ThenURLHasQueryItemsAdded),
        ("testWhenAddQueryItems_ThenURLHasQueryItemsAdded", testWhenAddQueryItems_ThenURLHasQueryItemsAdded),
        ("testWhenAddEmptyQueryItems_ThenNoQueryItemsAreAdded", testWhenAddEmptyQueryItems_ThenNoQueryItemsAreAdded)
    ]
}
