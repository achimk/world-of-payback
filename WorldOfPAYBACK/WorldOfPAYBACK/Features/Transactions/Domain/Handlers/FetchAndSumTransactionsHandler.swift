//
//  FetchAndSumTransactionsHandler.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class FetchAndSumTransactionsHandler: FetchAndSumTransactionsHandling {
    private let repository: TransactionItemRepository
    private let calculator = TransactionsSumByCurrencyCalculator()
    
    init(repository: TransactionItemRepository) {
        self.repository = repository
    }

    func allTransactions(with query: TransactionItemQuery, shouldSumTransactions: Bool, completion: @escaping Completion<TransactionItemsWithSum>) -> Cancelable {
        return make(fetchAllTransactionItems())
            .then(filterTransactionItems(with: query))
            .then(sortTransactionItems(with: query))
            .then(enrichTransactionSum(shouldSumTransactions))
            .transform(completion: completion)
    }
    
    private func fetchAllTransactionItems() -> AsyncTransformBlock<Void, [TransactionItem]> {
        return { [repository] (_, completion) in
            repository.allTransactionItems(completion: completion)
        }
    }
    
    private func filterTransactionItems(with query: TransactionItemQuery) -> AsyncTransformer<[TransactionItem], [TransactionItem]> {
        guard !query.filterCategories.isEmpty else {
            return MapTransformer { $0 }
        }
        return MapTransformer {
            $0.filter {
                query.filterCategories.contains($0.category)
            }
        }
    }
    
    private func sortTransactionItems(with query: TransactionItemQuery) -> AsyncTransformer<[TransactionItem], [TransactionItem]> {
        let sortOrder = query.sortBy.asSortOrderStrategy()
        return MapTransformer {
            $0.sorted(by: { sortOrder($0.bookingDate, $1.bookingDate) })
        }
    }
    
    private func enrichTransactionSum(_ shouldSumTransactions: Bool) -> AsyncTransformer<[TransactionItem], TransactionItemsWithSum> {
        guard shouldSumTransactions else {
            return MapTransformer { TransactionItemsWithSum(sum: nil, items: $0) }
        }
        
        return MapTransformer { [calculator] (transactions) in
            let moneyPile = transactions.map { $0.amount }
            let sum = calculator.sum(moneyPile)
            return TransactionItemsWithSum(sum: sum, items: transactions)
        }
    }
}
