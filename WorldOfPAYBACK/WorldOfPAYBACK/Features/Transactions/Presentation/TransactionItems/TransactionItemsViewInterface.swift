//
//  TransactionItemsViewInterface.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemsViewInterface: AnyObject {
    func presentInitial()
    func presentProgress()
    func presentTransactionsViewData(_ viewData: CurrencyTransactionItemsViewData)
    func presentErrorMessage(_ errorMessage: String)
}
