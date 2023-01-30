//
//  TransactionItemsQueryViewFactory.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

struct TransactionItemsQueryViewFactory {
    
    static func make(
        coordinator: TransactionItemsQueryFlowCoordinating,
        query: TransactionItemsQuery,
        container: Container = .shared) -> UIViewController
    {
        let localisations = container.resolve(TransactionItemsQueryLocalisation.self)
        let queryBuilder = OneTransactionCategoryQueryBuilder(query: query)
        
        let presenter = TransactionItemsQueryPresenter(
            coordinator: coordinator,
            localisation: localisations,
            queryBuilder: queryBuilder)
        
        let view = TransactionItemsQueryViewController(
            eventHandler: presenter,
            localisation: localisations)
        
        presenter.attach(view)
        
        return view
    }
}
