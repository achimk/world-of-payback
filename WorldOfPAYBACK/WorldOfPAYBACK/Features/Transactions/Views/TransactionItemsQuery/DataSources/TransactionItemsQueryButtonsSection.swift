//
//  TransactionItemsQueryButtonsSection.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TransactionItemsQueryButtonsSection: TableDataSourceSection {
    typealias ButtonViewData = TransactionItemsQueryViewData.ButtonViewData
    private var buttons: [ButtonViewData] = []
    
    func setup(with tableView: UITableView) {
        tableView.register(cellType: ContainerTableViewCell<PrimaryButton>.self)
    }
    
    func update(with buttons: [ButtonViewData]) {
        self.buttons = buttons
    }
    
    func numberOfItems() -> Int {
        return buttons.count
    }
    
    func cell(in tableView: UITableView, at index: Int, indexPath: IndexPath) -> UITableViewCell {
        let viewData = buttons[index]
        let cell = tableView.dequeueReusableCell(for: indexPath, as: ContainerTableViewCell<PrimaryButton>.self)
        cell.containedView.setup(
            title: viewData.title,
            isEnabled: viewData.isEnabled,
            onSelectHandler: viewData.onSelectHandler)
        return cell
    }
}
