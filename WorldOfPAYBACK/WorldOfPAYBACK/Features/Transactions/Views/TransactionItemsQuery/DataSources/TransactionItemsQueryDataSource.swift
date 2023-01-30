//
//  TransactionItemsQueryDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TransactionItemsQueryDataSource: TableViewDataSource {
    private let filtersSection = TransactionItemsQueryFiltersSection()
    private let buttonsSection = TransactionItemsQueryButtonsSection()
    
    override init() {
        super.init()
        sections = [filtersSection, buttonsSection]
    }
    
    override func setup(with tableView: UITableView) {
        super.setup(with: tableView)
    }
    
    func update(with viewData: TransactionItemsQueryViewData) {
        filtersSection.update(with: viewData.filters)
        buttonsSection.update(with: [viewData.clearButton, viewData.acceptButton])
        reloadData()
    }
}
