//
//  TransactionItemViewDataBuilder.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class TransactionItemViewDataBuilder {
    private let dateFormatter: DateFormatting
    private let currencyFormatter: CurrencyFormatting
    private var onSelectHandler: (TransactionItem) -> Void = { _ in }
    
    init(
        dateFormatter: DateFormatting,
        currencyFormatter: CurrencyFormatting
    ) {
        self.dateFormatter = dateFormatter
        self.currencyFormatter = currencyFormatter
    }
    
    @discardableResult
    func set(selectHandler: @escaping (TransactionItem) -> Void) -> Self {
        onSelectHandler = selectHandler
        return self
    }
    
    func build(for item: TransactionItem) -> TransactionItemViewData {
        return TransactionItemViewData(
            bookingDate: dateFormatter.string(from: item.bookingDate, dateFormat: ""), // TODO: Implement!
            partnerName: item.partnerName,
            summary: item.summary,
            amount: currencyFormatter.string(from: item.amount),
            onSelectHandler: { [onSelectHandler] in onSelectHandler(item) })
    }
    
}
