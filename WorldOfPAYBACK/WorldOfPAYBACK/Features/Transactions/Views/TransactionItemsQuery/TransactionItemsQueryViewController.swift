//
//  TransactionItemsQueryViewController.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import UIKit

class TransactionItemsQueryViewController: TableViewController {
    private let dataSource = TransactionItemsQueryDataSource()
    private let eventHandler: TransactionItemsQueryEventHandling
    
    init(eventHandler: TransactionItemsQueryEventHandling,
         localisation: TransactionItemsQueryLocalisation)
    {
        self.eventHandler = eventHandler
        super.init(tableViewStyle: .plain)
        self.title = localisation.transactionsQueryViewTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        eventHandler.viewLoaded()
    }
    
    private func setupNavigationBar() {
        let closeImage = ThemeManager.currentTheme().systemIcons.close
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: closeImage,
            style: .plain,
            target: self,
            action: #selector(closeSelected))
    }
    
    private func setupTableView() {
        dataSource.setup(with: tableView)
    }
    
    @objc
    private func closeSelected() {
        eventHandler.cancel()
    }
}

extension TransactionItemsQueryViewController: TransactionItemsQueryViewInterface {
    
    func presentQueryViewData(_ viewData: TransactionItemsQueryViewData) {
        dataSource.update(with: viewData)
    }
}
