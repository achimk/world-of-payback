//
//  DefaultCurrencyFormatter.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation

class DefaultCurrencyFormatter: CurrencyFormatting {
    private let formatter = NumberFormatter()
    
    func string(from money: Money) -> String {
        formatter.currencySymbol = currencyToSymbol(money.currency)
        if let formatted = formatter.string(from: NSNumber(nonretainedObject: money.amount)) {
            return formatted
        }
        return String(describing: money.amount) + " " + currencyToSymbol(money.currency)
    }
}

private func currencyToSymbol(_ currency: Currency) -> String {
    switch currency {
    case .EUR:
        return "€"
    case .GBP:
        return "£"
    case .USD:
        return "$"
    case .unknownCode(let code):
        return code
    }
}
