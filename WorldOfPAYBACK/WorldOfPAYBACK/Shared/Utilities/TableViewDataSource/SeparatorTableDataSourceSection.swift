//
//  SeparatorTableDataSourceSection.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

class SeparatorTableDataSourceSection: TableDataSourceSection {
    private var isEnabled: Bool
    private var height: CGFloat
    
    init(isEnabled: Bool = true, height: CGFloat = 60) {
        self.isEnabled = isEnabled
        self.height = height
    }
    
    func update(isEnabled: Bool, height: CGFloat) {
        self.isEnabled = isEnabled
        self.height = height
    }
    
    func setup(with tableView: UITableView) {
        tableView.register(cellType: SeparatorTableViewCell.self)
    }
    
    func numberOfItems() -> Int {
        return isEnabled ? 1 : 0
    }
    
    func cell(in tableView: UITableView, at index: Int, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, as: SeparatorTableViewCell.self)
        cell.selectionStyle = .none
        cell.heightAnchor.constraint(equalToConstant: height).isActive = true
        return cell
    }
}

private class SeparatorTableViewCell: UITableViewCell, Reusable {
}
