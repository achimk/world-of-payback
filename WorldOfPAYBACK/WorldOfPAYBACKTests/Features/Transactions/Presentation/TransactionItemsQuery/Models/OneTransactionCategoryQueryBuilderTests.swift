//
//  OneTransactionCategoryQueryBuilderTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class OneTransactionCategoryQueryBuilderTests: XCTestCase {
    
    func test_initialiseWithMultipleCategories_shouldSelectOnlyOne() {
        let initialQuery = TransactionItemsQuery(
            sortBy: .bookingDateDescending,
            filterCategories: [.other, .savings])
        let query = OneTransactionCategoryQueryBuilder(query: initialQuery)
            .build()
        
        XCTAssertEqual(query.filterCategories.count, 1)
    }
    
    func test_toggleMultipleCategories_shouldAggregateOnlyLast() {
        let query = OneTransactionCategoryQueryBuilder(query: .default)
            .toggle(category: .savings)
            .toggle(category: .other)
            .build()
        
        XCTAssertEqual(query.filterCategories.count, 1)
        XCTAssertTrue(query.filterCategories.contains(.other))
    }
    
    func test_clear_shouldBeEmpty() {
        let query = OneTransactionCategoryQueryBuilder(query: .default)
            .toggle(category: .savings)
            .toggle(category: .other)
            .clear()
            .build()
        
        XCTAssertEqual(query.filterCategories.count, 0)
    }
}
