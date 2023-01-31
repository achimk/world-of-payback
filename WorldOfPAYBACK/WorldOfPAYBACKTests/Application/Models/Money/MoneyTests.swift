//
//  MoneyTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
@testable import WorldOfPAYBACK
import XCTest

class MoneyTests: XCTestCase {
    
    func test_addAmountToMoney_shouldReturnMoneyWithCorrectSum() {
        let oneEuro = Money(amount: 1, currency: .EUR)
        let result = oneEuro.add(1)
        XCTAssertEqual(result.currency, .EUR)
        XCTAssertEqual(result.amount, 2)
    }
    
    func test_addMoneyWithSameCurrency_shouldReturnMoneyWithCorrectSum() throws {
        let oneEuro = Money(amount: 1, currency: .EUR)
        let result = try oneEuro.add(oneEuro)
        XCTAssertEqual(result.currency, .EUR)
        XCTAssertEqual(result.amount, 2)
    }
    
    func test_addMoneyWithOtherCurrency_shouldThrowError() {
        let oneEuro = Money(amount: 1, currency: .EUR)
        let oneDolar = Money(amount: 1, currency: .USD)
        let result = Result.init(catching: { try oneEuro.add(oneDolar) })
        
        XCTAssertTrue(result.isFailure)
        result.ifFailure { error in
            XCTAssertNotNil(error as? InconsistentCurrencyError)
        }
    }
}
