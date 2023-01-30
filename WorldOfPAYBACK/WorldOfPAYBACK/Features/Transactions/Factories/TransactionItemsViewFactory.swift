//
//  TransactionItemsViewFactory.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

struct TransactionItemsViewFactory {
    
    static func make(
        coordinator: TransactionItemsFlowCoordinating,
        container: Container = .shared) -> UIViewController
    {
        let dateFormatter = container.resolve(DateFormatting.self)
        let currencyFormatter = container.resolve(CurrencyFormatting.self)
        let localisation = container.resolve(TransactionItemsLocalisation.self)
        let transactionHandler = container.resolve(FetchAndSumTransactionsHandling.self)
        let query = TransactionItemsQuery.default
        
        let presenter = TransactionItemsPresenter(
            coordinator: coordinator,
            dateFormatter: dateFormatter,
            currencyFormatter: currencyFormatter,
            localisation: localisation,
            transactionsHandler: transactionHandler,
            initialQuery: query)
        
        let view = TransactionItemsViewController(
            eventHandler: presenter,
            localisation: localisation)
        
        presenter.attach(view)
        
        return view
    }
}
