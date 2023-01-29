//
//  CurrencyTranactionItemsViewDataBuilder.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class CurrencyTransactionItemsViewDataBuilder {
    private let currencyFormatter: CurrencyFormatting
    private let itemBuilder: TransactionItemViewDataBuilder
    
    init(
        itemBuilder: TransactionItemViewDataBuilder,
        currencyFormatter: CurrencyFormatting
    ) {
        self.itemBuilder = itemBuilder
        self.currencyFormatter = currencyFormatter
    }
    
    func build(for result: TransactionItemsWithSum) -> CurrencyTransactionItemsViewData {
        let currencySums = result.sum.map { makeCurrencySums(from: $0) } ?? []
        let items = result.items.map { itemBuilder.build(for: $0) }
        return CurrencyTransactionItemsViewData(
            currencySums: currencySums,
            items: items)
    }
    
    private func makeCurrencySums(from calculatedTransactions: CalculatedTransactions) -> [String] {
        return calculatedTransactions.byCurrencies
            .map { Money(amount: $1, currency: $0) }
            .sorted(by: { $0.amount > $1.amount })
            .map { currencyFormatter.string(from: $0) }
    }
}
