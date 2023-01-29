//
//  MockCurrencyFormatter.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
@testable import WorldOfPAYBACK

class MockCurrencyFormatter: CurrencyFormatting {
    var stringFromMoneyGenerator: (Money) -> String = {
        return "\($0.amount) \(currencyToString($0.currency))"
    }
    
    func string(from money: Money) -> String {
        return stringFromMoneyGenerator(money)
    }
}

private func currencyToString(_ currency: Currency) -> String {
    switch currency {
    case .EUR: return "EUR"
    case .USD: return "USD"
    case .GBP: return "GBP"
    case .unknownCode(let code): return code
    }
}
