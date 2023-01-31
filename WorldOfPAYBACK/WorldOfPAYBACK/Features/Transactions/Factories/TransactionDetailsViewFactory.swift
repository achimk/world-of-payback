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
        let presenter = TransactionDetailsPresenter(transactionItem: transactionItem)
        let view = TransactionDetailsViewController(eventHandler: presenter)
        presenter.attach(view)
        return view
    }
}
