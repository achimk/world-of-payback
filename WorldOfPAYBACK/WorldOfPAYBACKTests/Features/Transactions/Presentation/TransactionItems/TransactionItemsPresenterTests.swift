//
//  TransactionItemsPresenterTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class TransactionItemsPresenterTests: XCTestCase {
    
    // As a user of the App, I want to see a list of (mocked) transactions. Each item in the list displays `bookingDate`, `partnerDisplayName`, `transactionDetail.description`, `value.amount` and `value.currency`. *(see attached JSON File)*
    
    func test_fetchTransactionsOnViewLoaded_shouldPresentCorrectNumberOfItems() {
        let components = makeTestComponents()
        components.repository.tranactionItemsGenerator = {
            MockTransactionItemBuilder().build(count: 10)
        }
        
        components.presenter.viewLoaded()
        
        XCTAssertTrue(components.view.presentInitialInvoked)
        XCTAssertTrue(components.view.presentProgressInvoked)
        XCTAssertTrue(components.view.presentTransactionsViewDataInvoked)
        XCTAssertFalse(components.view.presentErrorMessageInvoked)
        XCTAssertEqual(components.view.viewDataSnapshots.count, 1)
        XCTAssertEqual(components.view.viewDataSnapshots.last?.items.count, 10)
    }
    
    func test_fetchTransactionsOnRefreshContent_shouldPresentCorrectNumberOfItems() {
        let components = makeTestComponents()
        components.repository.tranactionItemsGenerator = {
            MockTransactionItemBuilder().build(count: 10)
        }
        
        components.presenter.viewLoaded()
        components.presenter.refreshContent()
        
        XCTAssertTrue(components.view.presentInitialInvoked)
        XCTAssertTrue(components.view.presentProgressInvoked)
        XCTAssertTrue(components.view.presentTransactionsViewDataInvoked)
        XCTAssertFalse(components.view.presentErrorMessageInvoked)
        XCTAssertEqual(components.view.viewDataSnapshots.count, 2)
        XCTAssertEqual(components.view.viewDataSnapshots.last?.items.count, 10)
    }
    
    // As a user of the App, I want to have the list of transactions sorted by `bookingDate` from newest (top) to oldest (bottom).
    
    func test_fetchTransactions_shouldBeInCorrectOrder() {
        let inputDates = [
            Date(timeIntervalSince1970: 3 * 86400),
            Date(timeIntervalSince1970: 1 * 86400),
            Date(timeIntervalSince1970: 2 * 86400)
        ]
        
        let formattedOutput = [
            "1970-01-04 00:00:00 +0000",
            "1970-01-03 00:00:00 +0000",
            "1970-01-02 00:00:00 +0000"
        ]
        
        let components = makeTestComponents()
        components.repository.tranactionItemsGenerator = {
            makeTransactionsWithDates(inputDates)
        }
        
        components.presenter.viewLoaded()
        
        XCTAssertEqual(components.view.viewDataSnapshots.last?.items.count, 3)
        components.view.viewDataSnapshots.last.ifPresent { viewData in
            XCTAssertEqual(viewData.items.map { $0.bookingDate }, formattedOutput)
        }
        
    }
    
    // As a user of the App, I want to get feedback when loading of the transactions is ongoing or an Error occurs.
    
    func test_fetchTransactionsProgress_shouldPresentLoadingState() {
        let components = makeTestComponents()
        components.repository.setCompletionOnHold()
        components.repository.tranactionItemsGenerator = {
            MockTransactionItemBuilder().build(count: 10)
        }
        
        components.presenter.viewLoaded()
        
        XCTAssertTrue(components.view.presentInitialInvoked)
        XCTAssertTrue(components.view.presentProgressInvoked)
        XCTAssertFalse(components.view.presentTransactionsViewDataInvoked)
        XCTAssertFalse(components.view.presentErrorMessageInvoked)
    }
    
    func test_fetchTransactionsFailure_shouldPresentFailureState() {
        let components = makeTestComponents()
        components.repository.tranactionItemsGenerator = {
            throw NSError(domain: "Test", code: 0, userInfo: nil)
        }
        
        components.presenter.viewLoaded()
        
        XCTAssertTrue(components.view.presentInitialInvoked)
        XCTAssertTrue(components.view.presentProgressInvoked)
        XCTAssertFalse(components.view.presentTransactionsViewDataInvoked)
        XCTAssertTrue(components.view.presentErrorMessageInvoked)
    }
    
    // As a user of the App, I want to filter the list of transactions by `category`.
    
    func test_fetchTransactionsByCategory_shouldPresentCategoryItemsOnly() {
        let components = makeTestComponents()
        components.repository.tranactionItemsGenerator = {
            var items: [TransactionItem] = []
            var builder = MockTransactionItemBuilder()
            builder.categoryGeneator = { _ in .savings }
            items.append(contentsOf: builder.build(count: 3))
            builder.categoryGeneator = { _ in .other }
            items.append(contentsOf: builder.build(count: 6))
            return items
        }
        
        components.presenter.viewLoaded()
        components.presenter.updateTransactionsQuery(.init(sortBy: .bookingDateDescending, filterCategories: [.savings]))
        
        XCTAssertEqual(components.view.viewDataSnapshots.first?.items.count, 9)
        XCTAssertEqual(components.view.viewDataSnapshots.last?.items.count, 3)
    }
    
    func test_filterContent_shouldNavigateToFilters() {
        let components = makeTestComponents()
        
        components.presenter.filterContent()
        
        XCTAssertTrue(components.coordinator.presentTransactionFiltersInvoked)
    }
    
    // As a user of the App, I want to see the sum of filtered transactions somewhere on the Transaction-list view.
    
    func test_fetchTransactionsByCategory_shouldPresentTransactionsSum() {
        let components = makeTestComponents()
        components.repository.tranactionItemsGenerator = {
            var items: [TransactionItem] = []
            var builder = MockTransactionItemBuilder()
            builder.categoryGeneator = { _ in .savings }
            builder.amountGeneator = { index in Money(amount: 1, currency: .EUR) }
            items.append(contentsOf: builder.build(count: 3))
            builder.categoryGeneator = { _ in .other }
            builder.amountGeneator = { index in Money(amount: 1, currency: .USD) }
            items.append(contentsOf: builder.build(count: 6))
            return items
        }
        
        components.presenter.viewLoaded()
        components.presenter.updateTransactionsQuery(.init(sortBy: .bookingDateDescending, filterCategories: [.savings]))
        
        XCTAssertEqual(components.view.viewDataSnapshots.last?.currencySums, ["3 EUR"])
    }
    
    func test_fetchTransactionsWithoutCategory_shouldNotPresentTransactionsSum() {
        let components = makeTestComponents()
        components.repository.tranactionItemsGenerator = {
            var items: [TransactionItem] = []
            var builder = MockTransactionItemBuilder()
            builder.categoryGeneator = { _ in .savings }
            builder.amountGeneator = { index in Money(amount: 1, currency: .EUR) }
            items.append(contentsOf: builder.build(count: 3))
            builder.categoryGeneator = { _ in .other }
            builder.amountGeneator = { index in Money(amount: 1, currency: .USD) }
            items.append(contentsOf: builder.build(count: 6))
            return items
        }
        
        components.presenter.viewLoaded()
        components.presenter.updateTransactionsQuery(.init(sortBy: .bookingDateDescending, filterCategories: []))
        
        XCTAssertEqual(components.view.viewDataSnapshots.last?.currencySums, [])
    }
    
    // As a user of the App, I want to select a transaction and navigate to its details. The details-view should just display `partnerDisplayName` and `transactionDetail.description`.
    
    func test_selectTransaction_shouldNavigateToDetailsPage() {
        let components = makeTestComponents()
        components.repository.tranactionItemsGenerator = {
            MockTransactionItemBuilder().build(count: 10)
        }
        
        components.presenter.viewLoaded()
        components.view.viewDataSnapshots.last?.items.first?.onSelectHandler()
        
        XCTAssertTrue(components.coordinator.presentTransactionDetailsInvoked)
    }
}

extension TransactionItemsPresenterTests {
    
    private struct TestComponents {
        let presenter: TransactionItemsPresenter
        let coordinator: MockTransactionItemsFlowCoordinator
        let localisation: MockTransactionItemsLocalisation
        let repository: MockTransactionItemRepository
        let view: MockTransactionItemsView
    }
    
    private func makeTestComponents() -> TestComponents {
        let coordinator = MockTransactionItemsFlowCoordinator()
        let localisation = MockTransactionItemsLocalisation()
        let repository = MockTransactionItemRepository()
        let transactionsHandler = FetchAndSumTransactionsHandler(repository: repository)
        let view = MockTransactionItemsView()
        let presenter = TransactionItemsPresenter(
            coordinator: coordinator,
            dateFormatter: MockDateFormatter(),
            currencyFormatter: MockCurrencyFormatter(),
            localisation: localisation,
            transactionsHandler: transactionsHandler,
            initialQuery: .default)
        
        presenter.attach(view)
        
        return TestComponents(
            presenter: presenter,
            coordinator: coordinator,
            localisation: localisation,
            repository: repository,
            view: view)
    }
}

// MARK: - Mocks

private class MockTransactionItemsFlowCoordinator: TransactionItemsFlowCoordinating {
    private(set) var presentTransactionFiltersInvoked = false
    private(set) var presentTransactionDetailsInvoked = false
    
    func presentTransactionFilters(completion: @escaping (TransactionItemsQuery) -> Void) {
        presentTransactionFiltersInvoked = true
    }
    
    func presentTransactionDetails(for item: TransactionItem) {
        presentTransactionDetailsInvoked = true
    }
}

private class MockTransactionItemsLocalisation: TransactionItemsLocalisation {
    func transactionItemsTitle() -> String {
        return "transactions"
    }
    
    func transactionItemsLoadingFailed(with error: Error) -> String {
        return "error"
    }
}

private class MockTransactionItemsView: TransactionItemsViewInterface {
    private(set) var presentInitialInvoked = false
    private(set) var presentProgressInvoked = false
    private(set) var presentTransactionsViewDataInvoked = false
    private(set) var presentErrorMessageInvoked = false
    
    private(set) var isProgress = false
    private(set) var viewDataSnapshots: [CurrencyTransactionItemsViewData] = []
    private(set) var errorMessageSnapshots: [String] = []
    
    func presentInitial() {
        presentInitialInvoked = true
    }
    
    func presentProgress() {
        presentProgressInvoked = true
        isProgress = true
    }
    
    func presentTransactionsViewData(_ viewData: CurrencyTransactionItemsViewData) {
        isProgress = false
        presentTransactionsViewDataInvoked = true
        viewDataSnapshots.append(viewData)
    }
    
    func presentErrorMessage(_ errorMessage: String) {
        isProgress = false
        presentErrorMessageInvoked = true
        errorMessageSnapshots.append(errorMessage)
    }
}
