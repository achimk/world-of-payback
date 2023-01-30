//
//  TransactionItemsDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TransactionItemsDataSource: TableViewDataSource {
    private let transactionCurrencySection = TransactionCurrencySection()
    private let transactionItemsSection = TransactionItemsSection()
    
    override init() {
        super.init()
        sections = [transactionCurrencySection, transactionItemsSection]
    }
    
    func update(with viewData: CurrencyTransactionItemsViewData) {
        transactionCurrencySection.update(with: viewData.sums)
        transactionItemsSection.update(with: viewData.items)
        reloadData()
    }
}
