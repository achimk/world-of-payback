//
//  TransactionItemViewData.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

struct TransactionItemViewData {
    let bookingDate: String
    let partnerName: String
    let summary: String?
    let amount: String
    let onSelectHandler: () -> Void
}
