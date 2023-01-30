//
//  TransactionCurrencySection.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TransactionCurrencySection: TableDataSourceSection {
    private var viewData: CurrencyTransactionItemsViewData.CurrencySumsViewData?
    
    func setup(with tableView: UITableView) {
        tableView.register(cellType: ContainerTableViewCell<TitleValueItemList>.self)
    }
    
    func update(with viewData: CurrencyTransactionItemsViewData.CurrencySumsViewData) {
        self.viewData = viewData
    }
    
    func numberOfItems() -> Int {
        guard let viewData = viewData else {
            return 0
        }
        return viewData.currencySums.isEmpty ? 0 : 1
    }
    
    func cell(in tableView: UITableView, at index: Int, indexPath: IndexPath) -> UITableViewCell {
        guard let viewData = viewData else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(for: indexPath, as: ContainerTableViewCell<TitleValueItemList>.self)
        cell.containedView.setup(title: viewData.title, value: viewData.currencySumsJoined)
        return cell
    }
}
