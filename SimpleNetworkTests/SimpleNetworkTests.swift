//
//  SimpleNetworkTests.swift
//  SimpleNetworkTests
//
//  Created by Barbara Rollet on 23/02/2020.
//  Copyright © 2020 Barbara Rollet. All rights reserved.
//

import XCTest
@testable import SimpleNetwork

class SimpleNetworkTests: XCTestCase {
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
}
