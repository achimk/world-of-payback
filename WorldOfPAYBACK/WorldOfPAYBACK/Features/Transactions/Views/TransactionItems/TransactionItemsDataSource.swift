//
//  TransactionItemsDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TransactionItemsDataSource: NSObject {
    private var viewData: CurrencyTransactionItemsViewData?
    var reloadData: () -> Void = { }
    
    func update(with viewData: CurrencyTransactionItemsViewData) {
        self.viewData = viewData
        reloadData()
    }
}

extension TransactionItemsDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension TransactionItemsDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewData = viewData else {
            return 0
        }
        return viewData.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemViewData = viewData?.items[indexPath.row] ?? undefined()
        let cell = UITableViewCell()
        let view = TransactonItemView()
        cell.contentView.addAndFill(view)
        view.setup(with: itemViewData)
        return cell
    }
}
