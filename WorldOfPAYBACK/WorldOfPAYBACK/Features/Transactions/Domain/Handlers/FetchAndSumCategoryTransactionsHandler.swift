//
//  FetchAndSumCategoryTransactionsHandler.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class FetchAndSumCategoryTransactionsHandler: FetchAndSumCategoryTransactionsHandling {
    private let repository: TransactionItemRepository
    private let calculator = TransactionsSumByCurrencyCalculator()
    
    init(repository: TransactionItemRepository) {
        self.repository = repository
    }

    func allTransactions(with query: TransactionItemQuery, shouldSumTransactions: Bool, completion: @escaping Completion<TransactionItemsWithSum>) -> Cancelable {
        return make(fetchAllTransactionItems(with: query))
            .then(shouldIncludeTransactionSum(shouldSumTransactions))
            .transform(completion: completion)
    }
    
    private func fetchAllTransactionItems(with query: TransactionItemQuery) -> AsyncTransformBlock<Void, [TransactionItem]> {
        return { [repository] (_, completion) in
            repository.allTransactionItems(with: query, completion: completion)
        }
    }
    
    private func shouldIncludeTransactionSum(_ shouldSum: Bool) -> AsyncTransformer<[TransactionItem], TransactionItemsWithSum> {
        guard shouldSum else {
            return MapTransformer { TransactionItemsWithSum(sum: nil, items: $0) }
        }
        
        return MapTransformer { [calculator] (transactions) in
            let moneyPile = transactions.map { $0.amount }
            let sum = calculator.sum(moneyPile)
            return TransactionItemsWithSum(sum: sum, items: transactions)
        }
    }
}
