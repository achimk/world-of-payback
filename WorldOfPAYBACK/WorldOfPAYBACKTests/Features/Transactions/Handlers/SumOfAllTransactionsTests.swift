//
//  SumOfAllTransactionsTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class SumOfAllTransactionsTests: XCTestCase {
    
    // "Feed"-Feature: Displays different, user-targeted content (displayed via webviews, images, ads etc.). **Note:** It is also planned to display the sum of all Transactions from the "Transaction"-Feature.
    
    func test_sumAllTransactions_shouldProduceCorrectCalculations() {
        let components = makeTestComponents()
        var builder = MockTransactionItemBuilder()
        builder.amountGeneator = { index in
            return index % 2 == 0
                ? Money(amount: 1, currency: .EUR)
                : Money(amount: 1, currency: .USD)
        }
        components.repository.tranactionItemsGenerator = { builder.build(count: 10) }
        
        var result: Result<CalculatedTransactions, Error>?
        _ = components.handler.allTransactionsSum(completion: { result = $0 })
        
        XCTAssertTrue(result?.isSuccess == true)
        result?.ifSuccess { sum in
            XCTAssertEqual(sum.byCurrencies.count, 2)
            XCTAssertEqual(sum.byCurrencies[.EUR], 5)
            XCTAssertEqual(sum.byCurrencies[.USD], 5)
        }
    }
    
    func test_sumAllTransactions_shouldTransmitError() {
        let components = makeTestComponents()
        components.repository.tranactionItemsGenerator = { throw NSError(domain: "Test", code: 0, userInfo: nil) }
        
        var result: Result<CalculatedTransactions, Error>?
        _ = components.handler.allTransactionsSum(completion: { result = $0 })
        
        XCTAssertTrue(result?.isFailure == true)
    }
}

extension SumOfAllTransactionsTests {
    
    private struct TestComponents {
        let handler: SumOfAllTransactionsHandler
        let repository: MockTransactionItemRepository
    }
    
    private func makeTestComponents() -> TestComponents {
        let repository = MockTransactionItemRepository()
        let handler = SumOfAllTransactionsHandler(
            repository: repository)
        
        return .init(
            handler: handler,
            repository: repository)
    }
}
