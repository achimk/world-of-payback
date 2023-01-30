//
//  TableDataSourceSection.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

protocol TableDataSourceSection {
    func setup(with tableView: UITableView)
    func numberOfItems() -> Int
    func select(in tableView: UITableView, at index: Int, indexPath: IndexPath)
    func cell(in tableView: UITableView, at index: Int, indexPath: IndexPath) -> UITableViewCell
}

extension TableDataSourceSection {
    
    func setup(with tableView: UITableView) {
    }
    
    func select(in tableView: UITableView, at index: Int, indexPath: IndexPath) {
    }
    
    func numberOfItems() -> Int {
        return 0
    }
    
}
