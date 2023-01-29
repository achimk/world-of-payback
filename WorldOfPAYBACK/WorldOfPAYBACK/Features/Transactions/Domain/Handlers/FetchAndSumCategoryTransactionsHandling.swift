//
//  FetchAndSumCategoryTransactionsHandling.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol FetchAndSumCategoryTransactionsHandling {
    func allTransactions(with query: TransactionItemQuery, shouldSumTransactions: Bool, completion: Completion<TransactionItemsWithSum>) -> Cancelable
}
