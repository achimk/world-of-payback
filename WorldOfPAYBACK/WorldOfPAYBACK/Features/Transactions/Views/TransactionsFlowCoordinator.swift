//
//  TransactionsFlowCoordinator.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import UIKit

class TransactionsFlowCoordinator {
    private let navigationController: UINavigationController
    private var onAcceptQueryHandler: ((TransactionItemsQuery) -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startFlow() {
        let viewController = TransactionItemsViewFactory.make(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension TransactionsFlowCoordinator: TransactionItemsFlowCoordinating {
    
    func presentTransactionFilters(completion: @escaping (TransactionItemsQuery) -> Void) {
        onAcceptQueryHandler = completion
        let viewController = TransactionItemsQueryViewFactory.make()
        navigationController.present(viewController, animated: true, completion: nil)
    }
    
    func presentTransactionDetails(for item: TransactionItem) {
        // TODO: Implement!
    }
}

extension TransactionsFlowCoordinator: TransactionItemsQueryFlowCoordinating {
    
    func presentTransactionItems(for query: TransactionItemsQuery) {
        onAcceptQueryHandler?(query)
        onAcceptQueryHandler = nil
    }
}
