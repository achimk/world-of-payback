//
//  TransactionItemsQueryViewFactory.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

struct TransactionItemsQueryViewFactory {
    
    static func make(container: Container = .shared) -> UIViewController {
        // TODO: Implement!
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        return viewController
    }
}
