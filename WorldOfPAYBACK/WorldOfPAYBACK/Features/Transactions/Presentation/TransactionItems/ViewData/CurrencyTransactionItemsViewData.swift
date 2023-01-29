//
//  CurrencyTransactionItemsViewData.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

struct CurrencyTransactionItemsViewData {
    let currencySums: [String]
    let items: [TransactionItemViewData]
    
    static let empty = CurrencyTransactionItemsViewData(currencySums: [], items: [])
}
