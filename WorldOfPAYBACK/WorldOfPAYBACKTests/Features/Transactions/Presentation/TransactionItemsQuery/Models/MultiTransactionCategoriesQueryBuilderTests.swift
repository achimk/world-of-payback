//
//  MultiTransactionCategoriesQueryBuilderTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class MultiTransactionCategoriesQueryBuilderTests: XCTestCase {
    
    func test_toggleMultipleCategories_shouldAggregateAll() {
        let query = MultiTransactionCategoriesQueryBuilder(
            sortBy: .bookingDateDescending,
            filterCategories: [])
            .toggle(category: .savings)
            .toggle(category: .other)
            .build()
        
        XCTAssertEqual(query.filterCategories.count, 2)
        XCTAssertTrue(query.filterCategories.contains(.savings))
        XCTAssertTrue(query.filterCategories.contains(.other))
    }
    
    func test_clear_shouldBeEmpty() {
        let query = MultiTransactionCategoriesQueryBuilder(
            sortBy: .bookingDateDescending,
            filterCategories: [])
            .toggle(category: .savings)
            .toggle(category: .other)
            .clear()
            .build()
        
        XCTAssertEqual(query.filterCategories.count, 0)
    }
}
