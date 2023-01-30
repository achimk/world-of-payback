//
//  TransactionsFlowCoordinator.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class TransactionsFlowCoordinator {
    
}

extension TransactionsFlowCoordinator: TransactionItemsFlowCoordinating {
    
    func presentTransactionFilters(completion: @escaping (TransactionItemsQuery) -> Void) {
        // TODO: Implement!
    }
    
    func presentTransactionDetails(for item: TransactionItem) {
        // TODO: Implement!
    }
}

extension TransactionsFlowCoordinator: TransactionItemsQueryFlowCoordinating {
    
    func presentTransactionItems(for query: TransactionItemsQuery) {
        // TODO: Implement!
    }
}
