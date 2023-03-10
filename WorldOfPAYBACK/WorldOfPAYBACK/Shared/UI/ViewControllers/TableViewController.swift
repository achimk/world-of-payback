//
//  TableViewController.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TableViewController: ViewController {
    let refreshControl = UIRefreshControl()
    let tableView: UITableView
    
    init(tableViewStyle: UITableView.Style) {
        tableView = UITableView(frame: .zero, style: tableViewStyle)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        view.addAndFill(tableView)
    }
    
    private func setupRefreshControl() {
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
    }
    
    @objc
    func refreshContent() {
        abstractMethod()
    }
}
