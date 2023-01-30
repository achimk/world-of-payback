//
//  UITableVIew+Reusable.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

extension UITableView {

    func register<Cell: UITableViewCell>(cellType: Cell.Type) where Cell: Reusable {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func register<View: UITableViewHeaderFooterView>(headerFooterViewType: View.Type) where View: Reusable {
        register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath, as cellType: Cell.Type = Cell.self) -> Cell where Cell: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return undefined("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<View: UITableViewHeaderFooterView>(as viewType: View.Type = View.self) -> View? where View: Reusable {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? View? else {
            return undefined("Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) matching type \(viewType.self)")
        }
        return view
    }
}
