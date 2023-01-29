//
//  TransactionsSumByCurrencyCalculator.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class TransactionsSumByCurrencyCalculator {
    
    func sum(_ moneyPile: [Money]) -> CalculatedTransactions {
        var byCurrencies: [Currency: Amount] = [:]
        
        moneyPile.forEach { money in
            let sum = byCurrencies[money.currency] ?? .zero
            byCurrencies[money.currency] = sum + money.amount
        }
        
        return CalculatedTransactions(byCurrencies: byCurrencies)
    }
}
