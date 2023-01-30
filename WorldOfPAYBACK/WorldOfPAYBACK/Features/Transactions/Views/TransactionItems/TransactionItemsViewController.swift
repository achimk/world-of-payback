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
        dataSource.reloadData = tableView.reloadData
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @objc
    override func refreshContent() {
        eventHandler.refreshContent()
    }
    
    @objc
    private func presentFilters() {
        
    }
}

extension TransactionItemsViewController: TransactionItemsViewInterface {
    
    func presentInitial() {
        print("-> Initial")
    }
    
    func presentProgress() {
        print("-> Progress")
        startProgress()
    }
    
    func presentTransactionsViewData(_ viewData: CurrencyTransactionItemsViewData) {
        print("-> Success: \(viewData.items.count)")
        endProgress()
        dataSource.update(with: viewData)
    }
    
    func presentErrorMessage(_ errorMessage: String) {
        print("-> Error: \(errorMessage)")
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
