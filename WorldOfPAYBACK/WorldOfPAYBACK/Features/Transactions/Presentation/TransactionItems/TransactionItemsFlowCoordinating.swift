//
//  TransactionItemsFlowCoordinating.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemsFlowCoordinating {
    func presentTransactionFilters(for currentQuery: TransactionItemsQuery, completion: @escaping (TransactionItemsQuery) -> Void)
    func presentTransactionDetails(for item: TransactionItem)
}
