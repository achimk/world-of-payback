//
//  TransactionItemsViewController.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import UIKit

class TransactionItemsViewController: TableViewController {
    
    @objc
    override func refreshContent() {
        
    }
}

extension TransactionItemsViewController: TransactionItemsViewInterface {
    
    func presentInitial() {
        
    }
    
    func presentProgress() {
        
    }
    
    func presentTransactionsViewData(_ viewData: CurrencyTransactionItemsViewData) {
        
    }
    
    func presentErrorMessage(_ errorMessage: String) {
        
    }
}

class TransactionItemsDataSource: NSObject {
    
}

extension TransactionItemsDataSource: UITableViewDelegate {
    
}

extension TransactionItemsDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
