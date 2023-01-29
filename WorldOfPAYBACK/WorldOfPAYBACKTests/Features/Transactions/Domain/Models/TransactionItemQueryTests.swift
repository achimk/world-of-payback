//
//  TransactionItemQueryTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class TransactionItemQueryTests: XCTestCase {
    
    private enum Const {
        static let oneDay = 86400
    }
    
    private let inputDates = [
        Date(timeIntervalSince1970: TimeInterval(5 * Const.oneDay)),
        Date(timeIntervalSince1970: TimeInterval(3 * Const.oneDay)),
        Date(timeIntervalSince1970: TimeInterval(1 * Const.oneDay)),
        Date(timeIntervalSince1970: TimeInterval(2 * Const.oneDay)),
        Date(timeIntervalSince1970: TimeInterval(4 * Const.oneDay))
    ]
    
    func test_sortBookingDatesAscending_shouldBeInCorrectOrder() {
        let outputDates = [
            Date(timeIntervalSince1970: TimeInterval(1 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(2 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(3 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(4 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(5 * Const.oneDay))
        ]
        
        let sortStrategy = TransactionItemQuery.SortBy.bookingDateAscending.asSortOrderStrategy()
        let results = inputDates.sorted(by: sortStrategy)
        
        XCTAssertEqual(results, outputDates)
    }
    
    func test_sortBookingDatesDescending_shouldBeInCorrectOrder() {
        let outputDates = [
            Date(timeIntervalSince1970: TimeInterval(5 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(4 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(3 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(2 * Const.oneDay)),
            Date(timeIntervalSince1970: TimeInterval(1 * Const.oneDay))
        ]
        
        let sortStrategy = TransactionItemQuery.SortBy.bookingDateDescending.asSortOrderStrategy()
        let results = inputDates.sorted(by: sortStrategy)
        
        XCTAssertEqual(results, outputDates)
    }
    
    func test_createDefaultQuery_shouldMatchQueryParameters() {
        let query = TransactionItemQuery.default
        XCTAssertEqual(query.sortBy, .bookingDateDescending)
        XCTAssertEqual(query.filterCategories, [])
    }
}
