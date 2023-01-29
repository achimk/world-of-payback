//
//  SumOfAllTransactionsHandler.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class SumOfAllTransactionsHandler: SumOfAllTransactionsHandling {
    private let repository: TransactionItemRepository
    private let calculator = TransactionsSumByCurrencyCalculator()
    
    init(repository: TransactionItemRepository) {
        self.repository = repository
    }

    func allTransactionsSum(completion: @escaping Completion<CalculatedTransactions>) -> Cancelable {
        return make(fetchAllTransactionItems())
            .then(calculateSumByCurrencies())
            .transform(completion: completion)
    }
    
    private func fetchAllTransactionItems() -> AsyncTransformBlock<Void, [TransactionItem]> {
        return { [repository] (_, completion) in
            repository.allTransactionItems(with: .default, completion: completion)
        }
    }
    
    private func calculateSumByCurrencies() -> AsyncTransformer<[TransactionItem], CalculatedTransactions> {
        return MapTransformer { [calculator] (transactions) in
            let moneyPile = transactions.map { $0.amount }
            return calculator.sum(moneyPile)
        }
    }
}
