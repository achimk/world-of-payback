//
//  TransactionItemsQueryPresenterTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class TransactionItemsQueryPresenterTests: XCTestCase {
    
    func test_initialiseWithCustomQuery_shouldPresentCorrectState() {
        let query = TransactionItemQuery(
            sortBy: .bookingDateDescending,
            filterCategories: [.shopping, .savings])
        let components = makeTestComponents(query: query)
        
        components.presenter.viewLoaded()
        
        XCTAssertNotNil(components.view.lastQueryViewData)
        components.view.lastQueryViewData.ifPresent { viewData in
            viewData.filters.enumerated().forEach { (index, filter) in
                if index % 2 == 0 {
                    XCTAssertTrue(filter.isEnabled)
                } else {
                    XCTAssertFalse(filter.isEnabled)
                }
            }
        }
    }
    
    func test_viewLoaded_shouldPresentAllFilters() {
        let filtersCount = TransactionCategory.allCases.count
        let components = makeTestComponents()
        
        components.presenter.viewLoaded()
        
        XCTAssertNotNil(components.view.lastQueryViewData)
        components.view.lastQueryViewData.ifPresent { viewData in
            XCTAssertEqual(viewData.filters.count, filtersCount)
            viewData.filters.forEach { filter in
                XCTAssertFalse(filter.isEnabled)
            }
        }
    }
    
    func test_viewLoaded_shouldPresentCorrectButtonState() {
        let components = makeTestComponents()
        
        components.presenter.viewLoaded()
        
        XCTAssertNotNil(components.view.lastQueryViewData)
        components.view.lastQueryViewData.ifPresent { viewData in
            XCTAssertFalse(viewData.clearButton.isEnabled)
            XCTAssertTrue(viewData.acceptButton.isEnabled)
        }
    }
    
    func test_categoryEnable_shouldPresentCorrectFilterState() {
        let components = makeTestComponents()
        components.presenter.viewLoaded()
        
        // enable first filter
        enumerateFilters(
            in: components,
            filter: { (index, _) in index == 0 },
            action: { $1.onChangeHandler() })
        
        XCTAssertNotNil(components.view.lastQueryViewData)
        components.view.lastQueryViewData.ifPresent { viewData in
            viewData.filters.enumerated().forEach { (index, filter) in
                if index == 0 {
                    XCTAssertTrue(filter.isEnabled)
                } else {
                    XCTAssertFalse(filter.isEnabled)
                }
            }
        }
    }
    
    func test_categoryDisable_shouldPresentCorrectFilterState() {
        let components = makeTestComponents()
        components.presenter.viewLoaded()
        
        // enable first filter
        enumerateFilters(
            in: components,
            filter: { (index, _) in index == 0 },
            action: { $1.onChangeHandler() })
        
        // disable first filter
        enumerateFilters(
            in: components,
            filter: { (index, _) in index == 0 },
            action: { $1.onChangeHandler() })
        
        XCTAssertNotNil(components.view.lastQueryViewData)
        components.view.lastQueryViewData.ifPresent { viewData in
            viewData.filters.enumerated().forEach { (index, filter) in
                XCTAssertFalse(filter.isEnabled)
            }
        }
    }
    
    func test_clearFilters_shouldPresentCorrectFiltersState() {
        let components = makeTestComponents()
        components.presenter.viewLoaded()
        
        enumerateFilters(
            in: components,
            filter: { (index, _) in index % 2 == 0 },
            action: { $1.onChangeHandler() })
        
        components.view.lastQueryViewData?.clearButton.onSelectHandler()
        
        XCTAssertNotNil(components.view.lastQueryViewData)
        components.view.lastQueryViewData.ifPresent { viewData in
            viewData.filters.enumerated().forEach { (index, filter) in
                XCTAssertFalse(filter.isEnabled)
            }
        }
    }
    
    func test_acceptQueryWithoutChanges_shouldNotifyCoordinatorWithQuery() {
        let components = makeTestComponents()
        components.presenter.viewLoaded()
        
        components.view.lastQueryViewData?.acceptButton.onSelectHandler()
        
        XCTAssertTrue(components.coordinator.presentTransactionItemsInvoked)
        XCTAssertEqual(components.coordinator.lastQuery, .default)
    }
    
    func test_acceptQueryWithChanges_shouldNotifyCoordinatorWithQuery() {
        let expectation = TransactionItemQuery(
            sortBy: .bookingDateDescending,
            filterCategories: [.shopping, .savings])
        let components = makeTestComponents()
        components.presenter.viewLoaded()
        
        enumerateFilters(
            in: components,
            filter: { (index, _) in index % 2 == 0 },
            action: { $1.onChangeHandler() })
        
        components.view.lastQueryViewData?.acceptButton.onSelectHandler()
        
        XCTAssertTrue(components.coordinator.presentTransactionItemsInvoked)
        XCTAssertEqual(components.coordinator.lastQuery, expectation)
    }
}

extension TransactionItemsQueryPresenterTests {
    
    private struct TestComponents {
        let presenter: TransactionItemsQueryPresenter
        let coordinator: MockTransactionItemsQueryFlowCoordinator
        let localisation: MockTransactionItemsQueryLocalisation
        let view: MockTransactionItemsQueryView
    }
    
    private func makeTestComponents(query: TransactionItemQuery = .default) -> TestComponents {
        let coordinator = MockTransactionItemsQueryFlowCoordinator()
        let localisation = MockTransactionItemsQueryLocalisation()
        let view = MockTransactionItemsQueryView()
        let presenter = TransactionItemsQueryPresenter(
            coordinator: coordinator,
            localisation: localisation,
            query: query)
        
        presenter.attach(view)
        
        return TestComponents(
            presenter: presenter,
            coordinator: coordinator,
            localisation: localisation,
            view: view)
    }
    
    private func enumerateFilters(
        in testComponents: TestComponents,
        filter: (Int, TransactionItemsQueryViewData.FilterViewData) -> Bool,
        action: (Int, TransactionItemsQueryViewData.FilterViewData) -> Void
    ) {
        testComponents.view.lastQueryViewData?.filters.enumerated().filter(filter).forEach(action)
    }
}

// MARK: - Mocks

private class MockTransactionItemsQueryFlowCoordinator: TransactionItemsQueryFlowCoordinating {
    private(set) var presentTransactionItemsInvoked = false
    private(set) var lastQuery: TransactionItemQuery?
    
    func presentTransactionItems(for query: TransactionItemQuery) {
        presentTransactionItemsInvoked = true
        lastQuery = query
    }
}

private class MockTransactionItemsQueryView: TransactionItemsQueryViewInterface {
    private(set) var presentQueryViewDataInvoked = false
    private(set) var lastQueryViewData: TransactionItemsQueryViewData?
    private(set) var queryViewDataSnapshots: [TransactionItemsQueryViewData] = []
    
    func presentQueryViewData(_ viewData: TransactionItemsQueryViewData) {
        presentQueryViewDataInvoked = true
        lastQueryViewData = viewData
        queryViewDataSnapshots.append(viewData)
    }
}
