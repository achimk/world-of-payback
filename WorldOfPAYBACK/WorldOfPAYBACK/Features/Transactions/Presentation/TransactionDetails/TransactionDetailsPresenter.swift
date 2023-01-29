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
    
    init(itemViewData: TransactionItemViewData) {
        viewData = TransactionDetailsViewData(
            partnerName: itemViewData.partnerName,
            summary: itemViewData.summary)
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
