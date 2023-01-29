//
//  TransactionItem.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

struct TransactionItem {
    let partnerName: String
    let category: TransactionCategory
    let summary: String
    let bookingDate: Date
    let amount: Money
}
