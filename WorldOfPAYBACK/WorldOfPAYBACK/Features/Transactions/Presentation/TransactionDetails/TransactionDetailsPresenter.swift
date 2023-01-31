//
//  TransactionDetailsPresenter.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class TransactionDetailsPresenter {
    private let viewData: TransactionDetailsViewData
    private weak var view: TransactionDetailsViewInterface?
    
    init(transactionItem: TransactionItem) {
        viewData = TransactionDetailsViewData(
            partnerName: transactionItem.partnerName,
            summary: transactionItem.summary)
    }
}

extension TransactionDetailsPresenter {
    
    func attach(_ view: TransactionDetailsViewInterface) {
        self.view = view
    }
}

extension TransactionDetailsPresenter: TransactionDetailsEventHandling {
    
    func viewLoaded() {
        view?.presentTransactionDetails(viewData: viewData)
    }
}
