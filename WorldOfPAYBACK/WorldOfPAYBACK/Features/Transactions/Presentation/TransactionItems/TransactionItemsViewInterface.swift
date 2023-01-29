//
//  TransactionItemsViewInterface.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemsViewInterface: AnyObject {
    func presentProgress()
    func presentTransactionItems(_ items: [TransactionItemViewData])
    func presentErrorMessage(_ errorMessage: String)
}
