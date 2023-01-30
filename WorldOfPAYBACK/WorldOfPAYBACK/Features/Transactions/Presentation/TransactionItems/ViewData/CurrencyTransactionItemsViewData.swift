//
//  CurrencyTransactionItemsViewData.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

struct CurrencyTransactionItemsViewData {
    struct CurrencySumsViewData {
        let title: String
        let currencySums: [String]
        let currencySumsJoined: String
    }
    
    let sums: CurrencySumsViewData
    let items: [TransactionItemViewData]
}
