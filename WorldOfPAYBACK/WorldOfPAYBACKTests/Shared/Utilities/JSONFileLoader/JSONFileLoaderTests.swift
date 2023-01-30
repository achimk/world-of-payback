//
//  JSONFileLoaderTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class JSONFileLoaderTests: XCTestCase {
    
    private enum Const {
        static let filename = "test-transactions-response"
    }
    
    func test_loadDataWithInvalidFileName_shouldThrowError() {
        let loader = makeJSONFileLoader()
        let result = Result(catching: { try loader.loadData(filename: "test") })
        XCTAssertTrue(result.isFailure)
    }
    
    func test_loadDataWithInvalidContent_shouldThrowError() {
        let loader = makeJSONFileLoader()
        let result = Result(catching: { try loader.loadData(url: URL(fileURLWithPath: "test")) })
        XCTAssertTrue(result.isFailure)
    }
    
    func test_loadDataWithValidFileNameAndContent_shouldReturnCorrectData() {
        let loader = makeJSONFileLoader()
        let result = Result(catching: { try loader.loadData(filename: Const.filename) })
        XCTAssertTrue(result.isSuccess)
    }
    
    func testLoadAndDecodeWithInvalidType_shouldThrowError() {
        let loader = makeJSONFileLoader()
        let result = Result<[String], Error>(catching: {
            try loader.loadAndDecode(type: [String].self, filename: Const.filename)
        })
        XCTAssertTrue(result.isFailure)
    }
    
    func testLoadAndDecodeWithValidType_shouldReturnCorrectValue() {
        let loader = makeJSONFileLoader()
        let result = Result<TransactionItemsResponse, Error>(catching: {
            try loader.loadAndDecode(type: TransactionItemsResponse.self, filename: Const.filename)
        })
        XCTAssertTrue(result.isSuccess)
    }
    
    private func makeJSONFileLoader() -> JSONFileLoader {
        return JSONFileLoader(bundle: makeBundle())
    }
    
    private func makeBundle() -> Bundle {
        return Bundle(for: JSONFileLoaderTests.self)
    }
}
