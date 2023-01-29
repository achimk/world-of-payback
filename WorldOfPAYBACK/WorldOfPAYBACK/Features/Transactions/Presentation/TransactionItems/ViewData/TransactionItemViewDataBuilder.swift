//
//  TransactionItemViewDataBuilder.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

struct TransactionItemViewDataBuilder {
    private let dateFormatter: DateFormatting
    private let currencyFormatter: CurrencyFormatting
    private var onSelectHandler: () -> Void = { }
    
    init(
        dateFormatter: DateFormatting,
        currencyFormatter: CurrencyFormatting)
    {
        self.dateFormatter = dateFormatter
        self.currencyFormatter = currencyFormatter
    }
    
    func set(selectHandler: @escaping () -> Void) -> Self {
        return performOnCopy { builder in
            builder.onSelectHandler = selectHandler
        }
    }
    
    func build(for item: TransactionItem) -> TransactionItemViewData {
        return TransactionItemViewData(
            bookingDate: dateFormatter.string(from: item.bookingDate, dateFormat: ""), // TODO: Implement!
            partnerName: item.partnerName,
            summary: item.summary,
            amount: currencyFormatter.string(from: item.amount),
            onSelectHandler: onSelectHandler)
    }
    
    private func performOnCopy(_ action: (inout TransactionItemViewDataBuilder) -> Void) -> Self {
        var builder = self
        action(&builder)
        return builder
    }
}
