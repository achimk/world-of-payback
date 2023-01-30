//
//  TransactionItemsQueryFiltersSection.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TransactionItemsQueryFiltersSection: TableDataSourceSection {
    typealias FilterViewData = TransactionItemsQueryViewData.FilterViewData
    private var filters: [FilterViewData] = []
    
    func setup(with tableView: UITableView) {
        tableView.register(cellType: ContainerTableViewCell<CheckboxItemList>.self)
    }
    
    func update(with filters: [FilterViewData]) {
        self.filters = filters
    }
    
    func numberOfItems() -> Int {
        return filters.count
    }
    
    func select(in tableView: UITableView, at index: Int, indexPath: IndexPath) {
        filters[index].onChangeHandler()
    }
    
    func cell(in tableView: UITableView, at index: Int, indexPath: IndexPath) -> UITableViewCell {
        let filterViewData = filters[index]
        let cell = tableView.dequeueReusableCell(for: indexPath, as: ContainerTableViewCell<CheckboxItemList>.self)
        cell.containedView.setup(
            title: filterViewData.name,
            subtitle: nil,
            isOn: filterViewData.isEnabled)
        return cell
    }
}
