//
//  TableViewDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TableViewDataSource: NSObject {
    private(set) var reloadData: () -> Void = { }
    var sections: [TableDataSourceSection] = []
    
    func setup(with tableView: UITableView) {
        reloadData = tableView.reloadData
        tableView.delegate = self
        tableView.dataSource = self
        sections.forEach { $0.setup(with: tableView) }
    }
}

extension TableViewDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[indexPath.section].select(in: tableView, at: indexPath.row, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension TableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].cell(in: tableView, at: indexPath.row, indexPath: indexPath)
    }
}
