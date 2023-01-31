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
    private var presentedViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startFlow() {
        let viewController = TransactionItemsViewFactory.make(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension TransactionsFlowCoordinator: TransactionItemsFlowCoordinating {
    
    func presentTransactionFilters(for currentQuery: TransactionItemsQuery, completion: @escaping (TransactionItemsQuery) -> Void) {
        onAcceptQueryHandler = completion
        let viewController = TransactionItemsQueryViewFactory.make(coordinator: self, query: currentQuery)
        let navigation = embedIntoNavigation(viewController)
        presentedViewController = navigation
        navigationController.present(navigation, animated: true, completion: nil)
    }
    
    func presentTransactionDetails(for item: TransactionItem) {
        let viewController = TransactionDetailsViewFactory.make(transactionItem: item)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension TransactionsFlowCoordinator: TransactionItemsQueryFlowCoordinating {
    
    func dismissTransactionItemsQuery() {
        presentedViewController?.dismiss(animated: true, completion: nil)
        presentedViewController = nil
    }
    
    func presentTransactionItems(for query: TransactionItemsQuery) {
        onAcceptQueryHandler?(query)
        onAcceptQueryHandler = nil
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
}

private func embedIntoNavigation(_ viewController: UIViewController) -> UINavigationController {
    return UINavigationController(rootViewController: viewController)
}
