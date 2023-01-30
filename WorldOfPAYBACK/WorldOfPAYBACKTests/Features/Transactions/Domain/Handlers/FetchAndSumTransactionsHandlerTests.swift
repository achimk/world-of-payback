//
//  FetchAndSumTransactionsHandlerTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class FetchAndSumTransactionsHandlerTests: XCTestCase {
    
    private enum Const {
        static let oneDay = 86400
    }
    
    // As a user of the App, I want to see a list of (mocked) transactions. Each item in the list displays `bookingDate`, `partnerDisplayName`, `transactionDetail.description`, `value.amount` and `value.currency`.
    
    func test_fetchListOfTransactionsWithoutCategoryFilters_shouldContainsAllResults() {
        let components = makeTestComponents()
        let inputItems = MockTransactionItemBuilder().build(count: 10)
        components.repository.tranactionItemsGenerator = { inputItems }
        
        var result: Result<TransactionItemsWithSum, Error>?
        _ = components.handler.allTransactions(with: .default, shouldSumTransactions: false, completion: { result = $0 })
        
        XCTAssertTrue(result?.isSuccess == true)
        result?.ifSuccess { transactions in
            XCTAssertEqual(transactions.items.count, 10)
        }
    }
    
    // As a user of the App, I want to have the list of transactions sorted by `bookingDate` from newest (top) to oldest (bottom).
    
    func test_fetchListOfTransactions_shouldBeInCorrectOrder() {
        let inputDates = [
            Date(timeIntervalSince1970: TimeInterval(5 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(3 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(1 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(2 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(4 * Const.oneDay))
        ]
        
        let outputDates = [
            Date(timeIntervalSince1970: TimeInterval(5 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(4 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(3 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(2 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(1 * Const.oneDay))
        ]
        
        let components = makeTestComponents()
        let inputItems = makeTransactionsWithDates(inputDates)
        components.repository.tranactionItemsGenerator = { inputItems }
        
        var result: Result<TransactionItemsWithSum, Error>?
        _ = components.handler.allTransactions(with: .default, shouldSumTransactions: false, completion: { result = $0 })
        
        XCTAssertTrue(result?.isSuccess == true)
        result?.ifSuccess { transactions in
            XCTAssertEqual(transactions.items.count, 5)
            XCTAssertEqual(outputDates, transactions.items.map { $0.bookingDate })
        }
    }
    
    // As a user of the App, I want to get feedback when loading of the transactions is ongoing or an Error occurs.
    
    func test_fetchListOfTransactionsWithError_shouldTransmitError() {
        let components = makeTestComponents()
        components.repository.tranactionItemsGenerator = { throw NSError(domain: "Test", code: 0, userInfo: nil) }
        
        var result: Result<TransactionItemsWithSum, Error>?
        _ = components.handler.allTransactions(with: .default, shouldSumTransactions: false, completion: { result = $0 })
        
        XCTAssertTrue(result?.isFailure == true)
    }
    
    // As a user of the App, I want to filter the list of transactions by `category`.
    
    func test_fetchListOfTransactionsWithOneCategoryFilter_shouldContainsCorrectResults() {
        let components = makeTestComponents()
        var builder = MockTransactionItemBuilder()
        builder.categoryGeneator = { index in TransactionCategory.allCases[index % TransactionCategory.allCases.count] }
        components.repository.tranactionItemsGenerator = { builder.build(count: TransactionCategory.allCases.count * 3) }
        
        var result: Result<TransactionItemsWithSum, Error>?
        let query = TransactionItemsQuery(sortBy: .bookingDateDescending, filterCategories: [.other])
        _ = components.handler.allTransactions(with: query, shouldSumTransactions: false, completion: { result = $0 })
        
        XCTAssertTrue(result?.isSuccess == true)
        result?.ifSuccess { transactions in
            XCTAssertEqual(transactions.items.count, 3)
            transactions.items.forEach { transaction in
                XCTAssertEqual(transaction.category, .other)
            }
        }
    }
    
    func test_fetchListOfTransactionsWithManyCategoryFilters_shouldContainsCorrectResults() {
        let components = makeTestComponents()
        var builder = MockTransactionItemBuilder()
        builder.categoryGeneator = { index in TransactionCategory.allCases[index % TransactionCategory.allCases.count] }
        components.repository.tranactionItemsGenerator = { builder.build(count: TransactionCategory.allCases.count * 3) }
        
        var result: Result<TransactionItemsWithSum, Error>?
        let query = TransactionItemsQuery(sortBy: .bookingDateDescending, filterCategories: [.other, .savings])
        _ = components.handler.allTransactions(with: query, shouldSumTransactions: false, completion: { result = $0 })
        
        XCTAssertTrue(result?.isSuccess == true)
        result?.ifSuccess { transactions in
            XCTAssertEqual(transactions.items.count, 6)
            let categoryCount = transactions.items.reduce([TransactionCategory: Int]()) { partialResult, item in
                var partialResult = partialResult
                partialResult[item.category] = (partialResult[item.category] ?? 0) + 1
                return partialResult
            }
            XCTAssertEqual(categoryCount.count, 2)
            XCTAssertEqual(categoryCount[.savings], 3)
            XCTAssertEqual(categoryCount[.other], 3)
        }
    }
    
    // As a user of the App, I want to see the sum of filtered transactions somewhere on the Transaction-list view. *(Sum of `value.amount`)*
    
    func test_fetchListOfTransactionsWithCalculatedSum_shouldEnrichResultsWithSum() {
        let components = makeTestComponents()
        var builder = MockTransactionItemBuilder()
        builder.amountGeneator = { index in
            return index % 2 == 0
                ? Money(amount: 1, currency: .EUR)
                : Money(amount: 1, currency: .USD)
        }
        components.repository.tranactionItemsGenerator = { builder.build(count: 10) }
        
        var result: Result<TransactionItemsWithSum, Error>?
        _ = components.handler.allTransactions(with: .default, shouldSumTransactions: true, completion: { result = $0 })
        
        XCTAssertTrue(result?.isSuccess == true)
        result?.ifSuccess { transactions in
            XCTAssertNotNil(transactions.sum)
            transactions.sum.ifPresent { sum in
                XCTAssertEqual(sum.byCurrencies.count, 2)
                XCTAssertEqual(sum.byCurrencies[.EUR], 5)
                XCTAssertEqual(sum.byCurrencies[.USD], 5)
            }
        }
    }
    
    func test_fetchListOfTransactionsWithoutCalculatedSum_shouldNotCalculateSum() {
        let components = makeTestComponents()
        var builder = MockTransactionItemBuilder()
        builder.amountGeneator = { index in
            return index % 2 == 0
                ? Money(amount: 1, currency: .EUR)
                : Money(amount: 1, currency: .USD)
        }
        components.repository.tranactionItemsGenerator = { builder.build(count: 10) }
        
        var result: Result<TransactionItemsWithSum, Error>?
        _ = components.handler.allTransactions(with: .default, shouldSumTransactions: false, completion: { result = $0 })
        
        XCTAssertTrue(result?.isSuccess == true)
        result?.ifSuccess { transactions in
            XCTAssertNil(transactions.sum)
        }
    }
}

extension FetchAndSumTransactionsHandlerTests {
    
    private struct TestComponents {
        let handler: FetchAndSumTransactionsHandler
        let repository: MockTransactionItemRepository
    }
    
    private func makeTestComponents() -> TestComponents {
        let repository = MockTransactionItemRepository()
        let handler = FetchAndSumTransactionsHandler(
            repository: repository)
        
        return .init(
            handler: handler,
            repository: repository)
    }
}

