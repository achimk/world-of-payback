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
    private let localisation: TransactionItemsLocalisation
    
    init(
        itemBuilder: TransactionItemViewDataBuilder,
        currencyFormatter: CurrencyFormatting,
        localisation: TransactionItemsLocalisation
    ) {
        self.itemBuilder = itemBuilder
        self.currencyFormatter = currencyFormatter
        self.localisation = localisation
    }
    
    func build(for result: TransactionItemsWithSum) -> CurrencyTransactionItemsViewData {
        let currencySums = makeCurrencySums(from: result.sum)
        let items = result.items.map { itemBuilder.build(for: $0) }
        return CurrencyTransactionItemsViewData(
            sums: currencySums,
            items: items)
    }
    
    private func makeCurrencySums(from calculatedTransactions: CalculatedTransactions?) -> CurrencyTransactionItemsViewData.CurrencySumsViewData {
        let currencySums = calculatedTransactions?.byCurrencies
            .map { Money(amount: $1, currency: $0) }
            .sorted(by: { $0.amount > $1.amount })
            .map { currencyFormatter.string(from: $0) } ?? []
        let currencySumsJoined = currencySums.joined(separator: ", ")
        return .init(
            title: localisation.transactionItemsCurrencySumTitle(),
            currencySums: currencySums,
            currencySumsJoined: currencySumsJoined)
    }
}
