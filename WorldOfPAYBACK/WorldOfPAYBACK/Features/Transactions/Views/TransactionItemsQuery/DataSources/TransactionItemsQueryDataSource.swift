//
//  TransactionItemsQueryDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TransactionItemsQueryDataSource: TableViewDataSource {
    private let filtersSection = TransactionItemsQueryFiltersSection()
    private let separatorSection = SeparatorTableDataSourceSection(height: 44.0)
    private let buttonsSection = TransactionItemsQueryButtonsSection()
    
    override init() {
        super.init()
        sections = [filtersSection, separatorSection, buttonsSection]
    }
    
    override func setup(with tableView: UITableView) {
        super.setup(with: tableView)
    }
    
    func update(with viewData: TransactionItemsQueryViewData) {
        filtersSection.update(with: viewData.filters)
        buttonsSection.update(clearButton: viewData.clearButton, acceptButton: viewData.acceptButton)
        reloadData()
    }
}
