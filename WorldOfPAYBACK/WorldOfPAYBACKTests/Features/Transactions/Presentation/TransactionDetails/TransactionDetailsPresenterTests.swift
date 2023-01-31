//
//  TransactionDetailsPresenterTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class TransactionDetailsPresenterTests: XCTestCase {
    
    func test_viewLoaded_shouldPresentViewData() {
        let transactionItem = TransactionItem(
            partnerName: "partnerName",
            category: .savings,
            summary: "summary",
            bookingDate: Date(),
            amount: Money(amount: 1, currency: .EUR))
        
        let presenter = TransactionDetailsPresenter(transactionItem: transactionItem)
        let view = MockTransactionDetailsView()
        presenter.attach(view)
        
        presenter.viewLoaded()
        
        XCTAssertEqual(view.lastViewData?.partnerName, "partnerName")
        XCTAssertEqual(view.lastViewData?.summary, "summary")
    }
}

// MARK: - Mocks

class MockTransactionDetailsView: TransactionDetailsViewInterface {
    private(set) var lastViewData: TransactionDetailsViewData?
    func presentTransactionDetails(viewData: TransactionDetailsViewData) {
        lastViewData = viewData
    }
}
