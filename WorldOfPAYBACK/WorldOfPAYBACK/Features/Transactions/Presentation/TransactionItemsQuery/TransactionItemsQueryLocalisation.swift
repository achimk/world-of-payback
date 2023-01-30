//
//  TransactionItemsQueryLocalisation.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemsQueryLocalisation {
    func transactionsQueryTitleForTransactionCategory(_ category: TransactionCategory) -> String
    func transactionsQueryClearButtonTitle() -> String
    func transactionsQueryAcceptButtonTitle() -> String
}
