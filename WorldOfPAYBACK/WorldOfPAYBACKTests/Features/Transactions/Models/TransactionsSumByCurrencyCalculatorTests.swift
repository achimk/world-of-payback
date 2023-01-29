//
//  TransactionsSumByCurrencyCalculatorTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class TransactionsSumByCurrencyCalculatorTests: XCTestCase {

    func test_calculateForEmptyMoneyPile_shouldReturnEmpty() {
        let calculator = TransactionsSumByCurrencyCalculator()
        let result = calculator.sum([])
        XCTAssertEqual(result.byCurrencies.count, 0)
    }
    
    func test_calculateForOneCurrency_shouldReturnCorrectSum() {
        let inputs = [
            Money(amount: 1, currency: .EUR),
            Money(amount: 2, currency: .EUR),
            Money(amount: 3, currency: .EUR),
            Money(amount: 4, currency: .EUR),
            Money(amount: 5, currency: .EUR)
        ]
        let calculator = TransactionsSumByCurrencyCalculator()
        let result = calculator.sum(inputs)
        
        XCTAssertEqual(result.byCurrencies.count, 1)
        XCTAssertEqual(result.byCurrencies[.EUR], 15)
    }
    
    func test_calculateForManyCurrencies_shouldReturnCorrectSums() {
        let inputs = [
            Money(amount: 1, currency: .EUR),
            Money(amount: 2, currency: .USD),
            Money(amount: 3, currency: .EUR),
            Money(amount: 4, currency: .USD),
            Money(amount: 5, currency: .GBP)
        ]
        let calculator = TransactionsSumByCurrencyCalculator()
        let result = calculator.sum(inputs)
        
        XCTAssertEqual(result.byCurrencies.count, 3)
        XCTAssertEqual(result.byCurrencies[.EUR], 4)
        XCTAssertEqual(result.byCurrencies[.USD], 6)
        XCTAssertEqual(result.byCurrencies[.GBP], 5)
    }
}
