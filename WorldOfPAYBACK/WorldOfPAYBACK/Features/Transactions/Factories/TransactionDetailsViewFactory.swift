//
//  TransactionDetailsViewFactory.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

struct TransactionDetailsViewFactory {
    
    static func make(
        transactionItem: TransactionItem,
        container: Container = .shared) -> UIViewController
    {
        let localisation = container.resolve(TransactionDetailsLocalisation.self)
        let presenter = TransactionDetailsPresenter(transactionItem: transactionItem)
        let view = TransactionDetailsViewController(eventHandler: presenter, localisation: localisation)
        presenter.attach(view)
        return view
    }
}
