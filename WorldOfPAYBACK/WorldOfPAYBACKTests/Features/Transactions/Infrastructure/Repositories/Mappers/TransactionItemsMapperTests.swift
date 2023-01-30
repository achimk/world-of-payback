//
//  TransactionItemsMapperTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class TransactionItemsMapperTests: XCTestCase {
    
    func test_mapWhenAllValuesPresent_shouldMapResponse() {
        let validValue = TransactionItemResponse.Value(
            amount: Decimal(1),
            currency: "BGP")
        let validItems = [
            TransactionItemResponse(
                partnerDisplayName: "partnerDisplayName",
                alias: .init(reference: "reference"),
                category: 1,
                transactionDetail: .init(description: "description", bookingDate: Date(), value: validValue))
        ]
        
        let results = TransactionItemsMapper.map(.init(items: validItems))
        
        XCTAssertEqual(results.count, 1)
    }
    
    func test_mapWhenMissingValues_shouldNotMapResponse() {
        let invalidItems = [
            TransactionItemResponse(
                partnerDisplayName: nil,
                alias: nil,
                category: nil,
                transactionDetail: nil),
            TransactionItemResponse(
                partnerDisplayName: nil,
                alias: .init(reference: "reference"),
                category: 1,
                transactionDetail: .init(description: "description", bookingDate: Date(), value: nil)),
            TransactionItemResponse(
                partnerDisplayName: "partnerDisplayName",
                alias: .init(reference: "reference"),
                category: 1,
                transactionDetail: .init(description: "description", bookingDate: Date(), value: nil)),
            TransactionItemResponse(
                partnerDisplayName: "partnerDisplayName",
                alias: .init(reference: "reference"),
                category: 1,
                transactionDetail: .init(description: "description", bookingDate: Date(), value: .init(amount: nil, currency: "BGP"))),
            TransactionItemResponse(
                partnerDisplayName: "partnerDisplayName",
                alias: .init(reference: "reference"),
                category: 1,
                transactionDetail: .init(description: "description", bookingDate: Date(), value: .init(amount: 1, currency: nil))),
        ]
        
        let results = TransactionItemsMapper.map(.init(items: invalidItems))
        
        XCTAssertEqual(results.count, 0)
    }
}
