//
//  MockTransactionItemBuilder.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
@testable import WorldOfPAYBACK

struct MockTransactionItemBuilder {
    var categoryGeneator: (Int) -> TransactionCategory = { _ in .other }
    var bookingDateGenerator: (Int) -> Date = { _ in Date(timeIntervalSince1970: 0) }
    var amountGeneator: (Int) -> Money = { _ in Money(amount: 0, currency: .EUR) }
    
    func build() -> TransactionItem {
        return generate(for: 0)
    }
    
    func build(count: Int) -> [TransactionItem] {
        return (0..<count).map { generate(for: $0) }
    }
    
    private func generate(for index: Int) -> TransactionItem {
        return TransactionItem(
            partnerName: "Partner Name \(index)",
            category: categoryGeneator(index),
            summary: "Summary \(index)",
            bookingDate: bookingDateGenerator(index),
            amount: amountGeneator(index))
    }
}
