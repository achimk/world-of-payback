//
//  TransactionItemsViewController.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import UIKit

class TransactionItemsViewController: TableViewController {
    private let loadingOverlayView = LoadingOverlayView()
    private let dataSource = TransactionItemsDataSource()
    private let eventHandler: TransactionItemsEventHandling
    private var isInitial: Bool = true
    
    init(eventHandler: TransactionItemsEventHandling, localisation: TransactionItemsLocalisation) {
        self.eventHandler = eventHandler
        super.init(tableViewStyle: .plain)
        self.title = localisation.transactionItemsTitle()
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
        let image = ThemeManager.currentTheme().systemIcons.filter
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(presentFilters))
    }
    
    private func setupTableView() {
        dataSource.setup(with: tableView)
    }
    
    @objc
    override func refreshContent() {
        eventHandler.refreshContent()
    }
    
    @objc
    private func presentFilters() {
        eventHandler.filterContent()
    }
}

extension TransactionItemsViewController: TransactionItemsViewInterface {
    
    func presentInitial() {
    }
    
    func presentProgress() {
        startProgress()
    }
    
    func presentTransactionsViewData(_ viewData: CurrencyTransactionItemsViewData) {
        endProgress()
        dataSource.update(with: viewData)
    }
    
    func presentErrorMessage(_ errorMessage: String) {
        endProgress()
        presentErrorView(message: errorMessage)
    }
    
    private func startProgress() {
        if !refreshControl.isRefreshing {
            view.addAndFill(loadingOverlayView)
        }
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func endProgress() {
        refreshControl.endRefreshing()
        loadingOverlayView.removeFromSuperview()
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}
