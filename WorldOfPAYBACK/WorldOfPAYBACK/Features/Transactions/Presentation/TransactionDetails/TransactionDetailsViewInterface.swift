//
//  TransactionDetailsViewInterface.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionDetailsViewInterface: AnyObject {
    func presentTransactionDetails(viewData: TransactionDetailsViewData)
}
