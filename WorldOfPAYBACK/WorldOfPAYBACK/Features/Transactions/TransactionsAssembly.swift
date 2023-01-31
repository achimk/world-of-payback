//
//  TransactionsAssembly.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation

class TransactionsAssembly {
    
    // Repositories
    lazy var transactionItemRepository: TransactionItemRepository = makeTransactionItemRepository()
    
    // Handlers
    lazy var sumOfAllTransactionsHandler: SumOfAllTransactionsHandling = makeSumOfAllTransactionsHandler()
    lazy var fetchAndSumTransactionsHandler: FetchAndSumTransactionsHandling = makeFetchAndSumTransactionsHandler()
    
    
    // MARK: Repositories
    
    private func makeTransactionItemRepository() -> TransactionItemRepository {
        let repository = JSONFileBasedTransactionItemRepository()
        repository.set(delay: 0.750) // default delay
        repository.set(errorCondition: { $0 % 3 == 2 }) // failure every 3 request
        return repository
    }
    
    // MARK: Handlers
    
    private func makeSumOfAllTransactionsHandler() -> SumOfAllTransactionsHandling {
        return SumOfAllTransactionsHandler(repository: transactionItemRepository)
    }
    
    private func makeFetchAndSumTransactionsHandler() -> FetchAndSumTransactionsHandling {
        return FetchAndSumTransactionsHandler(repository: transactionItemRepository)
    }
}

extension TransactionsAssembly {
    
    static func assembleDependencies(with container: Container) {
        let dependencies = TransactionsAssembly()
        
        // Handlers
        container.register(SumOfAllTransactionsHandling.self, resolver: { _ in dependencies.sumOfAllTransactionsHandler })
        container.register(FetchAndSumTransactionsHandling.self, resolver: { _ in dependencies.fetchAndSumTransactionsHandler })
    }
}
