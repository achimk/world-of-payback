//
//  TransactionItemsSection.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TransactionItemsSection: TableDataSourceSection {
    private var listViewData: [TransactionItemViewData] = []
    
    func setup(with tableView: UITableView) {
        tableView.register(cellType: ContainerTableViewCell<TransactonItemView>.self)
    }
    
    func update(with listViewData: [TransactionItemViewData]) {
        self.listViewData = listViewData
    }
    
    func select(in tableView: UITableView, at index: Int, indexPath: IndexPath) {
        listViewData[index].onSelectHandler()
    }
    
    func numberOfItems() -> Int {
        return listViewData.count
    }
    
    func cell(in tableView: UITableView, at index: Int, indexPath: IndexPath) -> UITableViewCell {
        let viewData = listViewData[index]
        let cell = tableView.dequeueReusableCell(for: indexPath, as: ContainerTableViewCell<TransactonItemView>.self)
        cell.containedView.setup(with: viewData)
        return cell
    }
}
