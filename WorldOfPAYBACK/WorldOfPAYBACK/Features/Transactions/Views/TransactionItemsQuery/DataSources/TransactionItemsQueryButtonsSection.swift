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
        tableView.register(cellType: ContainerTableViewCell<SecondaryButton>.self)
    }
    
    func update(clearButton: ButtonViewData, acceptButton: ButtonViewData) {
        self.buttons = [clearButton, acceptButton]
    }
    
    func numberOfItems() -> Int {
        return buttons.count
    }
    
    func cell(in tableView: UITableView, at index: Int, indexPath: IndexPath) -> UITableViewCell {
        let viewData = buttons[index]
        switch index {
        case 0: return cellForSecondaryButton(viewData, in: tableView, at: indexPath)
        case 1: return cellForPrimaryButton(viewData, in: tableView, at: indexPath)
        default: return UITableViewCell()
        }
    }
    
    private func cellForPrimaryButton(_ viewData: ButtonViewData, in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, as: ContainerTableViewCell<PrimaryButton>.self)
        cell.containedView.setup(
            title: viewData.title,
            isEnabled: viewData.isEnabled,
            onSelectHandler: viewData.onSelectHandler)
        return cell
    }
    
    private func cellForSecondaryButton(_ viewData: ButtonViewData, in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, as: ContainerTableViewCell<SecondaryButton>.self)
        cell.containedView.setup(
            title: viewData.title,
            isEnabled: viewData.isEnabled,
            onSelectHandler: viewData.onSelectHandler)
        return cell
    }

}
