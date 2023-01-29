//
//  FetchAndSumTransactionsHandling.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol FetchAndSumTransactionsHandling {
    func allTransactions(with query: TransactionItemQuery, shouldSumTransactions: Bool, completion: @escaping Completion<TransactionItemsWithSum>) -> Cancelable
}
