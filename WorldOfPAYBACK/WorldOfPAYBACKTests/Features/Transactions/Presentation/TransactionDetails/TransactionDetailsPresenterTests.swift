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
        let itemViewData = TransactionItemViewData(
            bookingDate: "date",
            partnerName: "partnerName",
            summary: "summary",
            amount: "amount",
            onSelectHandler: { })
        
        let presenter = TransactionDetailsPresenter(itemViewData: itemViewData)
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
