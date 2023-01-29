//
//  TransactionItemsPresenter.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class TransactionItemsPresenter {
    private let viewDataBuilder: TransactionItemViewDataBuilder
    private let transactionsHandler: FetchAndSumTransactionsHandling
    private weak var view: TransactionItemsViewInterface?
    
    init(
        dateFormatter: DateFormatting,
        currencyFormatter: CurrencyFormatting,
        transactionsHandler: FetchAndSumTransactionsHandling)
    {
        self.viewDataBuilder = TransactionItemViewDataBuilder(
            dateFormatter: dateFormatter,
            currencyFormatter: currencyFormatter)
        self.transactionsHandler = transactionsHandler
    }
}

extension TransactionItemsPresenter {
    
    func attach(_ view: TransactionItemsViewInterface) {
        self.view = view
    }
}

extension TransactionItemsPresenter: TransactionItemsEventHandling {
    
    func viewLoaded() {
        
    }
    
    func refreshContent() {
        
    }
    
    func filterBy(category: TransactionCategory) {
        
    }
    
    func clearFilters() {
        
    }
}
