//
//  TransactionItemsQueryViewInterface.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemsQueryViewInterface: AnyObject {
    func presentQueryViewData(_ viewData: TransactionItemsQueryViewData)
}
