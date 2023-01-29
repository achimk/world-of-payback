//
//  TransactionItemsQueryFlowCoordinating.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemsQueryFlowCoordinating {
    func presentTransactionItems(for query: TransactionItemQuery)
}
